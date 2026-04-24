// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlng.h for the primary calling header

#include "Vlng__pch.h"
#include "Vlng__Syms.h"
#include "Vlng___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__ico(Vlng___024root* vlSelf);
#endif  // VL_DEBUG

void Vlng___024root___eval_triggers__ico(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_triggers__ico\n"); );
    // Body
    vlSelf->__VicoTriggered.set(0U, (IData)(vlSelf->__VicoFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vlng___024root___dump_triggers__ico(vlSelf);
    }
#endif
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__act(Vlng___024root* vlSelf);
#endif  // VL_DEBUG

void Vlng___024root___eval_triggers__act(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, (((IData)(vlSelf->freq_in) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__freq_in__0))) 
                                     | ((IData)(vlSelf->reset) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__reset__0)))));
    vlSelf->__VactTriggered.set(1U, (((IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q1__0))) 
                                     | ((IData)(vlSelf->reset) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__reset__0)))));
    vlSelf->__VactTriggered.set(2U, (((IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q2__0))) 
                                     | ((IData)(vlSelf->reset) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__reset__0)))));
    vlSelf->__VactTriggered.set(3U, (((IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q3) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__pre45__DOT__q3__0))) 
                                     | ((IData)(vlSelf->reset) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__reset__0)))));
    vlSelf->__VactTriggered.set(4U, (((IData)(vlSelf->Frequency_Divider_240_248__DOT__d) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__d__0))) 
                                     | ((IData)(vlSelf->reset) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__reset__0)))));
    vlSelf->__Vtrigprevexpr___TOP__freq_in__0 = vlSelf->freq_in;
    vlSelf->__Vtrigprevexpr___TOP__reset__0 = vlSelf->reset;
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q1__0 
        = vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1;
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q2__0 
        = vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2;
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__pre45__DOT__q3__0 
        = vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q3;
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__d__0 
        = vlSelf->Frequency_Divider_240_248__DOT__d;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vlng___024root___dump_triggers__act(vlSelf);
    }
#endif
}
