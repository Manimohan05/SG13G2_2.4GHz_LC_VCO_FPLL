// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlng.h for the primary calling header

#include "Vlng__pch.h"
#include "Vlng__Syms.h"
#include "Vlng___024root.h"

void Vlng___024root___ctor_var_reset(Vlng___024root* vlSelf);

Vlng___024root::Vlng___024root(Vlng__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vlng___024root___ctor_var_reset(this);
}

void Vlng___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vlng___024root::~Vlng___024root() {
}
