// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vlng.h for the primary calling header

#ifndef VERILATED_VLNG___024ROOT_H_
#define VERILATED_VLNG___024ROOT_H_  // guard

#include "verilated.h"


class Vlng__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vlng___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(freq_in,0,0);
    VL_IN8(reset,0,0);
    CData/*0:0*/ Frequency_Divider_240_248__DOT__d;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__div4__DOT__q1;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__div4__DOT__q2;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__pre45__DOT__q3;
    VL_IN8(select_mode,0,0);
    VL_OUT8(freq_out,0,0);
    CData/*0:0*/ Frequency_Divider_240_248__DOT__mc_sig;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__b;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__c;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__div4__DOT__q1_bar;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__div4__DOT__q2_bar;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__pre45__DOT__q2;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__pre45__DOT__d1;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__pre45__DOT__ff1__DOT__q;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__mod7__DOT__jk1__DOT__d_in;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__mod7__DOT__jk2__DOT__d_in;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__mod7__DOT__jk3__DOT__d_in;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__out_stg__DOT__q_out;
    CData/*0:0*/ Frequency_Divider_240_248__DOT__out_stg__DOT__q_bar_out;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__freq_in__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__reset__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q1__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q2__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__pre45__DOT__q3__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__d__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<5> __VactTriggered;
    VlTriggerVec<5> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vlng__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vlng___024root(Vlng__Syms* symsp, const char* v__name);
    ~Vlng___024root();
    VL_UNCOPYABLE(Vlng___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
