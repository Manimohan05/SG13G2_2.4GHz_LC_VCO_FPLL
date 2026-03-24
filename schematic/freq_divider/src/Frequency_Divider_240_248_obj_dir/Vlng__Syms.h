// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VLNG__SYMS_H_
#define VERILATED_VLNG__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vlng.h"

// INCLUDE MODULE CLASSES
#include "Vlng___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vlng__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vlng* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vlng___024root                 TOP;

    // CONSTRUCTORS
    Vlng__Syms(VerilatedContext* contextp, const char* namep, Vlng* modelp);
    ~Vlng__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
