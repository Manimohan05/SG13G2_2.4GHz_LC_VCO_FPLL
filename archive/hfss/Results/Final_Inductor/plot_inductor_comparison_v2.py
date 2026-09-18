"""
Scientific plot comparing inductor parameters across three design variations
using Scienceplots package for publication-quality figures.
Version 2: Colorblind-friendly palette with semi-transparent annotations
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scienceplots

# Use the science plot style
plt.style.use(['science', 'ieee', 'no-latex'])

# Read the CSV files
df_increased = pd.read_csv('All_params_5_increased.csv')
df_reduced = pd.read_csv('All_params_5_reduced.csv')
df_nominal = pd.read_csv('Final_inductor.csv')

# Clean data (remove rows with NaN values)
df_increased = df_increased.dropna()
df_reduced = df_reduced.dropna()
df_nominal = df_nominal.dropna()

# Filter data to 12 GHz
df_increased = df_increased[df_increased['F [GHz]'] <= 12]
df_reduced = df_reduced[df_reduced['F [GHz]'] <= 12]
df_nominal = df_nominal[df_nominal['F [GHz]'] <= 12]

# Create figure with single plot and dual y-axes
fig, ax1 = plt.subplots(1, 1, figsize=(7, 7))

# Colorblind-friendly palette (based on Wong 2011 and Okabe-Ito palette)
colors = {
    'q_nominal': '#0173B2',      # Blue (deuteranopia safe)
    'q_increased': '#DE8F05',    # Orange (protanopia safe)
    'q_reduced': '#CC78BC',      # Light purple (safe)
    'l_nominal': '#029E73',      # Teal/Green (safe)
    'l_increased': '#ECE133',    # Yellow (safe)
    'l_reduced': '#CA5050'       # Muted red (safer than bright red)
}

# Plot Quality Factor (Qdiff) on left y-axis
line_q1 = ax1.plot(df_nominal['F [GHz]'], df_nominal['Qdiff []'], 
         label='Q - Nominal', linewidth=2.5, color=colors['q_nominal'], 
         marker='o', markersize=2.5, markevery=30, alpha=0.9, zorder=2)
line_q2 = ax1.plot(df_increased['F [GHz]'], df_increased['Qdiff []'], 
         label='Q - All Params +5%', linewidth=2, color=colors['q_increased'],
         marker='s', markersize=2.5, markevery=30, linestyle='--', alpha=0.8, zorder=2)
line_q3 = ax1.plot(df_reduced['F [GHz]'], df_reduced['Qdiff []'], 
         label='Q - All Params -5%', linewidth=2, color=colors['q_reduced'],
         marker='^', markersize=2.5, markevery=30, linestyle='-.', alpha=0.8, zorder=2)

# Fill between to show Q sensitivity range
ax1.fill_between(df_nominal['F [GHz]'], 
                  df_reduced['Qdiff []'], 
                  df_increased['Qdiff []'],
                  alpha=0.08, color=colors['q_nominal'], zorder=1)

ax1.set_xlabel('Frequency (GHz)', fontsize=15, fontweight='bold')
ax1.set_ylabel('Quality Factor, Q', fontsize=15, fontweight='bold', color=colors['q_nominal'])
ax1.tick_params(axis='y', labelcolor=colors['q_nominal'], labelsize=13)
ax1.tick_params(axis='x', labelsize=13)
ax1.grid(True, alpha=0.25, linestyle=':', linewidth=0.6, zorder=0)
ax1.set_xlim(0, 12)
ax1.set_ylim(bottom=0)

# Create second y-axis for Inductance
ax2 = ax1.twinx()
line_l1 = ax2.plot(df_nominal['F [GHz]'], df_nominal['Ldiff []'], 
         label='L - Nominal', linewidth=2.5, color=colors['l_nominal'],
         marker='D', markersize=2.5, markevery=30, alpha=0.9, zorder=2)
line_l2 = ax2.plot(df_increased['F [GHz]'], df_increased['Ldiff []'], 
         label='L - All Params +5%', linewidth=2, color=colors['l_increased'],
         marker='v', markersize=2.5, markevery=30, linestyle='--', alpha=0.8, zorder=2)
line_l3 = ax2.plot(df_reduced['F [GHz]'], df_reduced['Ldiff []'], 
         label='L - All Params -5%', linewidth=2, color=colors['l_reduced'],
         marker='<', markersize=2.5, markevery=30, linestyle='-.', alpha=0.8, zorder=2)

# Fill between to show L sensitivity range
ax2.fill_between(df_nominal['F [GHz]'], 
                  df_reduced['Ldiff []'], 
                  df_increased['Ldiff []'],
                  alpha=0.08, color=colors['l_nominal'], zorder=1)

ax2.set_ylim(bottom=0)
ax2.set_ylabel('Differential Inductance, L (nH)', fontsize=15, fontweight='bold', color=colors['l_nominal'])
ax2.tick_params(axis='y', labelcolor=colors['l_nominal'], labelsize=13)

# Set title
ax1.set_title('Inductor Parametric Study: Q-Factor & Inductance vs Frequency', 
              fontsize=16, fontweight='bold', pad=15)

# Combine legends from both axes - place at top right
lines1, labels1 = ax1.get_legend_handles_labels()
lines2, labels2 = ax2.get_legend_handles_labels()
ax1.legend(lines1 + lines2, labels1 + labels2, loc='upper right', 
           frameon=True, fontsize=12, ncol=2, framealpha=0.95, 
           edgecolor='black', fancybox=True)

# Get values at 2.3, 2.45, and 2.7 GHz
frequencies = [2.3, 2.45, 2.7]
annotations_q = []
annotations_l = []

for freq_target in frequencies:
    idx = (df_nominal['F [GHz]'] - freq_target).abs().idxmin()
    q_val = df_nominal.loc[idx, 'Qdiff []']
    l_val = df_nominal.loc[idx, 'Ldiff []']
    freq_actual = df_nominal.loc[idx, 'F [GHz]']
    annotations_q.append((freq_actual, q_val))
    annotations_l.append((freq_actual, l_val))

# Create single annotation box for Q values at the three frequencies (semi-transparent)
q_text = "Quality Factor (Q):\n"
for freq, q in annotations_q:
    q_text += f"  @ {freq} GHz: {q:.2f}\n"

ax1.text(0.02, 0.98, q_text.strip(),
         transform=ax1.transAxes, fontsize=10, fontweight='bold',
         verticalalignment='top', horizontalalignment='left',
         bbox=dict(boxstyle='round,pad=0.7', facecolor='lightblue', 
                  edgecolor=colors['q_nominal'], alpha=0.7, linewidth=2.5),
         zorder=11)

# Create single annotation box for L values at the three frequencies (semi-transparent)
l_text = "Inductance (L):\n"
for freq, l in annotations_l:
    l_text += f"  @ {freq} GHz: {l:.3f} nH\n"

ax2.text(0.98, 0.02, l_text.strip(),
         transform=ax1.transAxes, fontsize=10, fontweight='bold',
         verticalalignment='bottom', horizontalalignment='right',
         bbox=dict(boxstyle='round,pad=0.7', facecolor='#e6ffe6', 
                  edgecolor=colors['l_nominal'], alpha=0.7, linewidth=2.5),
         zorder=11)

# Add vertical lines at these frequencies for reference
for freq in frequencies:
    ax1.axvline(x=freq, color='gray', linestyle=':', linewidth=1.2, alpha=0.5, zorder=1)

# Adjust layout to prevent overlap
plt.tight_layout()

# Save the figure in high resolution
plt.savefig('inductor_comparison_plot_v2.png', dpi=300, bbox_inches='tight')
plt.savefig('inductor_comparison_plot_v2.pdf', bbox_inches='tight')

print("Plot saved as 'inductor_comparison_plot_v2.png' and 'inductor_comparison_plot_v2.pdf'")
print("Changes: Colorblind-friendly palette + Semi-transparent annotation boxes")
print("\nValues at key frequencies:")
for freq, (f_actual, q), (_, l) in zip(frequencies, annotations_q, annotations_l):
    print(f"  @ {freq} GHz: Q = {q:.2f}, L = {l:.3f} nH")
plt.show()
