"""
Research-Grade Plotting Script for Inductor Q and L vs Frequency
Generates publication-quality plots from HFSS simulation results
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

# Set publication-quality plot parameters
plt.rcParams.update({
    'font.size': 11,
    'font.family': 'serif',
    'font.serif': ['Times New Roman', 'DejaVu Serif'],
    'axes.labelsize': 12,
    'axes.titlesize': 13,
    'xtick.labelsize': 10,
    'ytick.labelsize': 10,
    'legend.fontsize': 9,
    'figure.figsize': (8, 6),
    'figure.dpi': 300,
    'savefig.dpi': 300,
    'savefig.bbox': 'tight',
    'lines.linewidth': 1.5,
    'axes.linewidth': 1.0,
    'grid.linewidth': 0.5,
    'axes.grid': True,
    'grid.alpha': 0.3,
    'mathtext.fontset': 'stix',
})

def load_data(csv_file):
    """Load and parse the CSV data"""
    df = pd.read_csv(csv_file)
    # Clean up column names
    df.columns = df.columns.str.strip()
    return df

def extract_width_from_column(col_name):
    """Extract width value from column name"""
    import re
    match = re.search(r"'([\d.]+)um'", col_name)
    if match:
        return match.group(1)
    return None

def plot_Q_vs_freq(df, output_file='Q_vs_frequency.pdf'):
    """Plot Quality Factor vs Frequency"""
    fig, ax = plt.subplots(figsize=(8, 6))
    
    # Get frequency column
    freq = df['F [GHz]']
    
    # Plot Q for each width
    q_columns = [col for col in df.columns if 'Qdiff' in col]
    colors = plt.cm.viridis(np.linspace(0, 1, len(q_columns)))
    
    for idx, col in enumerate(q_columns):
        width = extract_width_from_column(col)
        label = f'$W$ = {width} μm' if width else col
        ax.plot(freq, df[col], label=label, color=colors[idx], marker='', linewidth=1.8)
    
    ax.set_xlabel('Frequency (GHz)', fontweight='normal')
    ax.set_ylabel('Quality Factor, $Q_{diff}$', fontweight='normal')
    ax.set_title('Differential Quality Factor vs Frequency', fontweight='bold', pad=15)
    ax.legend(loc='center left', bbox_to_anchor=(1.02, 0.5), frameon=True, fancybox=True, shadow=False, framealpha=0.9)
    ax.grid(True, linestyle='--', alpha=0.3)
    ax.set_xlim(left=0, right=10)
    ax.set_ylim(bottom=0)
    
    # Minor ticks
    ax.minorticks_on()
    ax.tick_params(which='both', direction='in', top=True, right=True)
    
    plt.tight_layout()
    plt.savefig(output_file, format='pdf', dpi=300, bbox_inches='tight')
    plt.savefig(output_file.replace('.pdf', '.png'), format='png', dpi=300, bbox_inches='tight')
    print(f"Saved Q vs Frequency plot to {output_file}")
    plt.close()

def plot_L_vs_freq(df, output_file='L_vs_frequency.pdf'):
    """Plot Inductance vs Frequency"""
    fig, ax = plt.subplots(figsize=(8, 6))
    
    # Get frequency column
    freq = df['F [GHz]']
    
    # Plot L for each width
    l_columns = [col for col in df.columns if 'Ldiff' in col]
    colors = plt.cm.plasma(np.linspace(0, 1, len(l_columns)))
    
    for idx, col in enumerate(l_columns):
        width = extract_width_from_column(col)
        label = f'$W$ = {width} μm' if width else col
        ax.plot(freq, df[col], label=label, color=colors[idx], marker='', linewidth=1.8)
    
    ax.set_xlabel('Frequency (GHz)', fontweight='normal')
    ax.set_ylabel('Differential Inductance, $L_{diff}$ (nH)', fontweight='normal')
    ax.set_title('Differential Inductance vs Frequency', fontweight='bold', pad=15)
    ax.legend(loc='center left', bbox_to_anchor=(1.02, 0.5), frameon=True, fancybox=True, shadow=False, framealpha=0.9)
    ax.grid(True, linestyle='--', alpha=0.3)
    ax.set_xlim(left=0, right=10)
    ax.set_ylim(bottom=0)
    
    # Minor ticks
    ax.minorticks_on()
    ax.tick_params(which='both', direction='in', top=True, right=True)
    
    plt.tight_layout()
    plt.savefig(output_file, format='pdf', dpi=300, bbox_inches='tight')
    plt.savefig(output_file.replace('.pdf', '.png'), format='png', dpi=300, bbox_inches='tight')
    print(f"Saved L vs Frequency plot to {output_file}")
    plt.close()

def plot_combined(df, output_file='combined_Q_L_vs_frequency.pdf'):
    """Plot both Q and L on separate subplots"""
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 10))
    
    # Get frequency column
    freq = df['F [GHz]']
    
    # Plot Q on top subplot
    q_columns = [col for col in df.columns if 'Qdiff' in col]
    colors_q = plt.cm.viridis(np.linspace(0, 1, len(q_columns)))
    
    for idx, col in enumerate(q_columns):
        width = extract_width_from_column(col)
        label = f'$W$ = {width} μm' if width else col
        ax1.plot(freq, df[col], label=label, color=colors_q[idx], linewidth=1.8)
    
    ax1.set_xlabel('Frequency (GHz)', fontweight='normal')
    ax1.set_ylabel('Quality Factor, $Q_{diff}$', fontweight='normal')
    ax1.set_title('(a) Differential Quality Factor vs Frequency', fontweight='bold', loc='left', pad=10)
    ax1.legend(loc='center left', bbox_to_anchor=(1.02, 0.5), frameon=True, fancybox=True, shadow=False, framealpha=0.9, ncol=1)
    ax1.grid(True, linestyle='--', alpha=0.3)
    ax1.set_xlim(left=0, right=10)
    ax1.set_ylim(bottom=0)
    ax1.minorticks_on()
    ax1.tick_params(which='both', direction='in', top=True, right=True)
    
    # Plot L on bottom subplot
    l_columns = [col for col in df.columns if 'Ldiff' in col]
    colors_l = plt.cm.plasma(np.linspace(0, 1, len(l_columns)))
    
    for idx, col in enumerate(l_columns):
        width = extract_width_from_column(col)
        label = f'$W$ = {width} μm' if width else col
        ax2.plot(freq, df[col], label=label, color=colors_l[idx], linewidth=1.8)
    
    ax2.set_xlabel('Frequency (GHz)', fontweight='normal')
    ax2.set_ylabel('Differential Inductance, $L_{diff}$ (nH)', fontweight='normal')
    ax2.set_title('(b) Differential Inductance vs Frequency', fontweight='bold', loc='left', pad=10)
    ax2.legend(loc='center left', bbox_to_anchor=(1.02, 0.5), frameon=True, fancybox=True, shadow=False, framealpha=0.9, ncol=1)
    ax2.grid(True, linestyle='--', alpha=0.3)
    ax2.set_xlim(left=0, right=10)
    ax2.set_ylim(bottom=0)
    ax2.minorticks_on()
    ax2.tick_params(which='both', direction='in', top=True, right=True)
    
    plt.tight_layout()
    plt.savefig(output_file, format='pdf', dpi=300, bbox_inches='tight')
    plt.savefig(output_file.replace('.pdf', '.png'), format='png', dpi=300, bbox_inches='tight')
    print(f"Saved combined plot to {output_file}")
    plt.close()

def plot_dual_axis(df, output_file='dual_axis_L_Q_vs_frequency.pdf'):
    """Plot L and Q on dual y-axes with shared x-axis"""
    fig, ax1 = plt.subplots(figsize=(9, 6))
    
    # Get frequency column
    freq = df['F [GHz]']
    
    # Plot L on left axis
    l_columns = [col for col in df.columns if 'Ldiff' in col]
    colors_l = plt.cm.plasma(np.linspace(0, 1, len(l_columns)))
    
    lines1 = []
    labels1 = []
    for idx, col in enumerate(l_columns):
        width = extract_width_from_column(col)
        label = f'$L_{{diff}}$: $W$ = {width} μm' if width else col
        line, = ax1.plot(freq, df[col], label=label, color=colors_l[idx], 
                         linewidth=1.8, linestyle='-')
        lines1.append(line)
        labels1.append(label)
    
    ax1.set_xlabel('Frequency (GHz)', fontweight='normal', fontsize=12)
    ax1.set_ylabel('Differential Inductance, $L_{diff}$ (nH)', fontweight='normal', 
                   fontsize=12, color='tab:red')
    ax1.tick_params(axis='y', labelcolor='tab:red')
    ax1.set_xlim(left=0, right=10)
    ax1.set_ylim(bottom=0)
    ax1.minorticks_on()
    ax1.tick_params(which='both', direction='in', top=True)
    ax1.grid(True, linestyle='--', alpha=0.3)
    
    # Create second y-axis for Q
    ax2 = ax1.twinx()
    
    # Plot Q on right axis
    q_columns = [col for col in df.columns if 'Qdiff' in col]
    colors_q = plt.cm.viridis(np.linspace(0, 1, len(q_columns)))
    
    lines2 = []
    labels2 = []
    for idx, col in enumerate(q_columns):
        width = extract_width_from_column(col)
        label = f'$Q_{{diff}}$: $W$ = {width} μm' if width else col
        line, = ax2.plot(freq, df[col], label=label, color=colors_q[idx], 
                         linewidth=1.8, linestyle='--')
        lines2.append(line)
        labels2.append(label)
    
    ax2.set_ylabel('Quality Factor, $Q_{diff}$', fontweight='normal', 
                   fontsize=12, color='tab:blue')
    ax2.tick_params(axis='y', labelcolor='tab:blue')
    ax2.set_ylim(bottom=0)
    ax2.minorticks_on()
    ax2.tick_params(which='both', direction='in')
    
    # Combine legends
    lines = lines1 + lines2
    labels = labels1 + labels2
    ax1.legend(lines, labels, loc='center left', frameon=True, fancybox=True, 
               shadow=False, framealpha=0.95, ncol=1, fontsize=8.5, bbox_to_anchor=(1.12, 0.5))
    
    ax1.set_title('Differential Inductance and Quality Factor vs Frequency', 
                  fontweight='bold', pad=15, fontsize=13)
    
    plt.tight_layout()
    plt.savefig(output_file, format='pdf', dpi=300, bbox_inches='tight')
    plt.savefig(output_file.replace('.pdf', '.png'), format='png', dpi=300, bbox_inches='tight')
    print(f"Saved dual-axis plot to {output_file}")
    plt.close()

def main():
    """Main function to generate all plots"""
    # Get the CSV file path
    csv_file = 'Width_variations.csv'
    
    # Check if file exists
    if not Path(csv_file).exists():
        print(f"Error: CSV file '{csv_file}' not found in current directory")
        print("Please run this script from the same directory as the CSV file,")
        print("or modify the csv_file variable in the main() function.")
        return
    
    print(f"Loading data from {csv_file}...")
    df = load_data(csv_file)
    
    print(f"Data shape: {df.shape[0]} frequency points, {df.shape[1]} columns")
    print("\nGenerating plots...")
    
    # Generate individual plots
    plot_Q_vs_freq(df, 'Q_vs_frequency.pdf')
    plot_L_vs_freq(df, 'L_vs_frequency.pdf')
    
    # Generate combined plot
    plot_combined(df, 'combined_Q_L_vs_frequency.pdf')
    
    # Generate dual-axis plot
    plot_dual_axis(df, 'dual_axis_L_Q_vs_frequency.pdf')
    
    print("\n✓ All plots generated successfully!")
    print("\nGenerated files:")
    print("  - Q_vs_frequency.pdf (and .png)")
    print("  - L_vs_frequency.pdf (and .png)")
    print("  - combined_Q_L_vs_frequency.pdf (and .png)")
    print("  - dual_axis_L_Q_vs_frequency.pdf (and .png)")
    print("\nNote: PDF format is recommended for publication-quality figures.")

if __name__ == '__main__':
    main()
