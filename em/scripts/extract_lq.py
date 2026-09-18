"""Differential inductance / quality factor extraction and de-embedding.

Two-step open-short de-embedding removes the pad and feed-line parasitics that
the solver sees but the device does not have:

    Y_dut_os = ( (Y_meas - Y_open)^-1 - (Y_short - Y_open)^-1 )^-1

The differential quantities follow from the de-embedded Z-parameters:

    Z_diff = z11 - z12 - z21 + z22
    L_diff = Im(Z_diff) / omega        Q_diff = Im(Z_diff) / Re(Z_diff)
"""
from __future__ import annotations

import numpy as np

__all__ = ["s_to_y", "y_to_s", "s_to_z", "deembed_open_short", "deembed_open",
           "diff_LQ", "summarise"]


def s_to_y(S, z0=50.0):
    n = S.shape[0]
    I = np.eye(n)
    Y = np.empty_like(S)
    for k in range(S.shape[2]):
        s = S[:, :, k]
        Y[:, :, k] = np.linalg.inv(I + s) @ (I - s) / z0
    return Y


def y_to_s(Y, z0=50.0):
    n = Y.shape[0]
    I = np.eye(n)
    S = np.empty_like(Y)
    for k in range(Y.shape[2]):
        y = Y[:, :, k] * z0
        S[:, :, k] = np.linalg.inv(I + y) @ (I - y)
    return S


def s_to_z(S, z0=50.0):
    n = S.shape[0]
    I = np.eye(n)
    Z = np.empty_like(S)
    for k in range(S.shape[2]):
        s = S[:, :, k]
        Z[:, :, k] = z0 * (I + s) @ np.linalg.inv(I - s)
    return Z


def deembed_open(S_meas, S_open, z0=50.0):
    """Shunt-parasitic removal only."""
    Ym, Yo = s_to_y(S_meas, z0), s_to_y(S_open, z0)
    return y_to_s(Ym - Yo, z0)


def deembed_open_short(S_meas, S_open, S_short, z0=50.0):
    """Full two-step open-short de-embedding."""
    Ym, Yo, Ys = s_to_y(S_meas, z0), s_to_y(S_open, z0), s_to_y(S_short, z0)
    out = np.empty_like(Ym)
    for k in range(Ym.shape[2]):
        a = np.linalg.inv(Ym[:, :, k] - Yo[:, :, k])
        b = np.linalg.inv(Ys[:, :, k] - Yo[:, :, k])
        out[:, :, k] = np.linalg.inv(a - b)
    return y_to_s(out, z0)


def diff_LQ(S, freqs, z0=50.0):
    """Differential L [H] and Q from 2-port S-parameters."""
    Z = s_to_z(S, z0)
    zd = Z[0, 0] - Z[0, 1] - Z[1, 0] + Z[1, 1]
    w = 2 * np.pi * np.asarray(freqs, float)
    with np.errstate(divide="ignore", invalid="ignore"):
        L = zd.imag / w
        Q = zd.imag / zd.real
    return L, Q


def summarise(freqs, L, Q, f0=2.45e9):
    """Report the numbers that characterise a tank inductor."""
    f = np.asarray(freqs, float)
    i = int(np.argmin(abs(f - f0)))
    good = np.isfinite(Q)
    ipk = int(np.argmax(np.where(good, Q, -np.inf)))
    srf = None
    sign = np.sign(L)
    for k in range(i, len(f) - 1):
        if sign[k] > 0 >= sign[k + 1]:
            srf = f[k]
            break
    return {
        "f0": f[i],
        "L_f0": float(L[i]),
        "Q_f0": float(Q[i]),
        "Q_peak": float(Q[ipk]),
        "f_Q_peak": float(f[ipk]),
        "SRF": None if srf is None else float(srf),
    }


def plot(freqs, L, Q, path, title="Spiral inductor", f0=2.45e9):
    """Write the standard L/Q versus frequency figure."""
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    f = np.asarray(freqs) / 1e9
    fig, ax1 = plt.subplots(figsize=(7, 4.4))
    ax2 = ax1.twinx()
    ax1.plot(f, Q, color="#1f4e9c", lw=2, label=r"$Q_{diff}$")
    ax2.plot(f, np.asarray(L) * 1e9, color="#1a7f4b", lw=2, label=r"$L_{diff}$")
    ax1.axvline(f0 / 1e9, color="0.6", ls="--", lw=1)
    ax1.set_xlabel("Frequency (GHz)")
    ax1.set_ylabel(r"Quality factor  $Q_{diff}$", color="#1f4e9c")
    ax2.set_ylabel(r"Differential inductance  $L_{diff}$ (nH)", color="#1a7f4b")
    ax1.tick_params(axis="y", colors="#1f4e9c")
    ax2.tick_params(axis="y", colors="#1a7f4b")
    ax1.grid(alpha=0.3)
    ax1.set_title(title)
    fig.tight_layout()
    fig.savefig(path, dpi=160)
    plt.close(fig)
    return path
