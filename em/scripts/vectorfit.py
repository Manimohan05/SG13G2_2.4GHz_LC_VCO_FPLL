"""Vector fitting (Gustavsen & Semlyen) with a shared pole set.

Fits a matrix-valued frequency response H(s) with

    H(s) ~= D + sum_k  R_k / (s - p_k)

using one pole set common to every matrix entry, which is what a lumped
equivalent circuit needs. Real-only arithmetic is used throughout so complex
poles come out as exact conjugate pairs.

Reference: B. Gustavsen and A. Semlyen, "Rational approximation of frequency
domain responses by vector fitting", IEEE Trans. Power Delivery, 1999.
"""
from __future__ import annotations

import numpy as np

__all__ = ["vector_fit", "eval_fit"]


def _start_poles(freqs, n):
    """Complex starting poles spread over the band, lightly damped."""
    w = 2 * np.pi * np.asarray(freqs, float)
    lo, hi = w.min(), w.max()
    if lo <= 0:
        lo = hi / 1000.0
    npair = n // 2
    beta = np.linspace(lo, hi, max(npair, 1))
    poles = []
    for b in beta:
        poles += [complex(-b / 100.0, b), complex(-b / 100.0, -b)]
    if n % 2:
        poles.append(complex(-(lo + hi) / 2.0, 0.0))
    return np.array(poles[:n])


def _pair_mask(poles, tol=1e-12):
    """Label poles: 0 real, 1 first of a conjugate pair, 2 second of a pair."""
    m = np.zeros(len(poles), int)
    i = 0
    while i < len(poles):
        if abs(poles[i].imag) < tol:
            m[i] = 0
            i += 1
        else:
            m[i], m[i + 1] = 1, 2
            i += 2
    return m


def _basis(s, poles, mask):
    """Real-valued partial-fraction basis columns for the given poles."""
    n = len(poles)
    A = np.zeros((len(s), n), complex)
    for k in range(n):
        if mask[k] == 0:
            A[:, k] = 1.0 / (s - poles[k])
        elif mask[k] == 1:
            A[:, k] = 1.0 / (s - poles[k]) + 1.0 / (s - np.conj(poles[k]))
        else:
            A[:, k] = 1j / (s - poles[k - 1]) - 1j / (s - np.conj(poles[k - 1]))
    return A


def vector_fit(freqs, H, n_poles=12, n_iter=12, fit_const=True, weight=None):
    """Fit H (nout, nin, nfreq) with `n_poles` shared poles.

    Returns (poles, residues, D) with residues shaped (nout, nin, n_poles).
    Residue columns follow the same real/pair convention as `poles`.
    """
    freqs = np.asarray(freqs, float)
    s = 2j * np.pi * freqs
    H = np.asarray(H, complex)
    if H.ndim == 1:
        H = H[None, None, :]
    nout, nin, nf = H.shape
    ne = nout * nin
    Hf = H.reshape(ne, nf)

    w = np.ones(nf) if weight is None else np.asarray(weight, float)
    poles = _start_poles(freqs, n_poles)

    for _ in range(n_iter):
        mask = _pair_mask(poles)
        A = _basis(s, poles, mask)                    # (nf, n)
        nD = 1 if fit_const else 0

        # --- pole relocation: solve for sigma's zeros --------------------
        rows, rhs = [], []
        ncols = ne * (n_poles + nD) + n_poles
        for e in range(ne):
            blk = np.zeros((nf, ncols), complex)
            blk[:, e * (n_poles + nD): e * (n_poles + nD) + n_poles] = A
            if fit_const:
                blk[:, e * (n_poles + nD) + n_poles] = 1.0
            blk[:, ne * (n_poles + nD):] = -A * Hf[e][:, None]
            rows.append(blk * w[:, None])
            rhs.append(Hf[e] * w)
        M = np.vstack(rows)
        b = np.concatenate(rhs)
        Mr = np.vstack([M.real, M.imag])
        br = np.concatenate([b.real, b.imag])
        sol, *_ = np.linalg.lstsq(Mr, br, rcond=None)
        cs = sol[ne * (n_poles + nD):]

        # zeros of sigma = eigenvalues of (A_diag - b c^T)
        Am = np.zeros((n_poles, n_poles))
        bv = np.zeros(n_poles)
        k = 0
        while k < n_poles:
            if mask[k] == 0:
                Am[k, k] = poles[k].real
                bv[k] = 1.0
                k += 1
            else:
                re, im = poles[k].real, poles[k].imag
                Am[k, k] = Am[k + 1, k + 1] = re
                Am[k, k + 1] = im
                Am[k + 1, k] = -im
                bv[k], bv[k + 1] = 2.0, 0.0
                k += 2
        new = np.linalg.eigvals(Am - np.outer(bv, cs))
        new = np.where(new.real > 0, -new.real + 1j * new.imag, new)   # enforce stability
        order = np.argsort(new.imag)
        new = new[order]
        # re-pair conjugates so the mask stays valid
        poles = _sort_pairs(new)

    # --- final residue solve -------------------------------------------
    mask = _pair_mask(poles)
    A = _basis(s, poles, mask)
    cols = np.hstack([A, np.ones((nf, 1))]) if fit_const else A
    Cr = np.vstack([cols.real, cols.imag])
    R = np.zeros((nout, nin, n_poles))
    D = np.zeros((nout, nin))
    for i in range(nout):
        for j in range(nin):
            y = Hf[i * nin + j]
            yr = np.concatenate([y.real, y.imag])
            sol, *_ = np.linalg.lstsq(Cr * np.concatenate([w, w])[:, None],
                                      yr * np.concatenate([w, w]), rcond=None)
            R[i, j] = sol[:n_poles]
            if fit_const:
                D[i, j] = sol[n_poles]
    return poles, R, D


def _sort_pairs(p):
    """Order poles so conjugate pairs are adjacent, +imag first.

    Eigenvalues of a real matrix are exact conjugate pairs, so the imaginary
    parts can simply be split by sign; taking only the positive half and
    re-emitting its conjugate keeps the count and the pairing exact.
    """
    p = np.asarray(p)
    scale = np.maximum(np.abs(p), 1e-30)
    is_real = np.abs(p.imag) <= 1e-9 * scale
    reals = np.sort(p[is_real].real)
    pos = p[~is_real & (p.imag > 0)]
    pos = pos[np.argsort(pos.imag)]

    out = []
    for z in pos:
        out += [complex(z.real, abs(z.imag)), complex(z.real, -abs(z.imag))]
    out += [complex(r, 0.0) for r in reals]

    # numerical drift can leave an unmatched complex value; pad or trim
    while len(out) < len(p):
        out.append(complex(-abs(np.mean(p.real)) or -1.0, 0.0))
    return np.array(out[:len(p)])


def eval_fit(freqs, poles, R, D):
    """Evaluate the fitted model on `freqs`."""
    s = 2j * np.pi * np.asarray(freqs, float)
    mask = _pair_mask(poles)
    A = _basis(s, poles, mask)
    nout, nin, _ = R.shape
    H = np.zeros((nout, nin, len(s)), complex)
    for i in range(nout):
        for j in range(nin):
            H[i, j] = A @ R[i, j] + D[i, j]
    return H
