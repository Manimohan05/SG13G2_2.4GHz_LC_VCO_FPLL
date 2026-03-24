// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlng.h for the primary calling header

#include "Vlng__pch.h"
#include "Vlng___024root.h"

VL_INLINE_OPT void Vlng___024root___ico_sequent__TOP__0(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___ico_sequent__TOP__0\n"); );
    // Body
    vlSelf->Frequency_Divider_240_248__DOT__mc_sig 
        = (1U & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__b) 
                 | (((~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__c)) 
                     & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__d))) 
                    | ((IData)(vlSelf->Frequency_Divider_240_248__DOT__c) 
                       & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__d) 
                          & (IData)(vlSelf->select_mode))))));
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__d1 
        = ((IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q2) 
           & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__mc_sig) 
              | (IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q3)));
}

void Vlng___024root___eval_ico(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        Vlng___024root___ico_sequent__TOP__0(vlSelf);
    }
}

void Vlng___024root___eval_triggers__ico(Vlng___024root* vlSelf);

bool Vlng___024root___eval_phase__ico(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_phase__ico\n"); );
    // Init
    CData/*0:0*/ __VicoExecute;
    // Body
    Vlng___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelf->__VicoTriggered.any();
    if (__VicoExecute) {
        Vlng___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void Vlng___024root___eval_act(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vlng___024root___nba_sequent__TOP__0(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___nba_sequent__TOP__0\n"); );
    // Body
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1 
        = ((~ (IData)(vlSelf->reset)) & (IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1_bar));
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1_bar 
        = (1U & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1)));
}

VL_INLINE_OPT void Vlng___024root___nba_sequent__TOP__1(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___nba_sequent__TOP__1\n"); );
    // Body
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2 
        = ((~ (IData)(vlSelf->reset)) & (IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2_bar));
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2_bar 
        = (1U & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2)));
}

VL_INLINE_OPT void Vlng___024root___nba_sequent__TOP__2(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___nba_sequent__TOP__2\n"); );
    // Body
    vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_out 
        = ((~ (IData)(vlSelf->reset)) & (IData)(vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_bar_out));
    vlSelf->freq_out = vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_out;
    vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_bar_out 
        = (1U & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_out)));
}

VL_INLINE_OPT void Vlng___024root___nba_sequent__TOP__3(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___nba_sequent__TOP__3\n"); );
    // Body
    vlSelf->Frequency_Divider_240_248__DOT__d = ((~ (IData)(vlSelf->reset)) 
                                                 & (IData)(vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk3__DOT__d_in));
    vlSelf->Frequency_Divider_240_248__DOT__c = ((~ (IData)(vlSelf->reset)) 
                                                 & (IData)(vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk2__DOT__d_in));
    vlSelf->Frequency_Divider_240_248__DOT__b = ((~ (IData)(vlSelf->reset)) 
                                                 & (IData)(vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk1__DOT__d_in));
    vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk1__DOT__d_in 
        = (1U & ((~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__b)) 
                 & ((~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__c)) 
                    | (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__d)))));
    vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk2__DOT__d_in 
        = (((~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__c)) 
            & (IData)(vlSelf->Frequency_Divider_240_248__DOT__b)) 
           | ((~ ((IData)(vlSelf->Frequency_Divider_240_248__DOT__b) 
                  | (IData)(vlSelf->Frequency_Divider_240_248__DOT__d))) 
              & (IData)(vlSelf->Frequency_Divider_240_248__DOT__c)));
    vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk3__DOT__d_in 
        = (((~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__d)) 
            & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__b) 
               & (IData)(vlSelf->Frequency_Divider_240_248__DOT__c))) 
           | ((~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__c)) 
              & (IData)(vlSelf->Frequency_Divider_240_248__DOT__d)));
    vlSelf->Frequency_Divider_240_248__DOT__mc_sig 
        = (1U & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__b) 
                 | (((~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__c)) 
                     & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__d))) 
                    | ((IData)(vlSelf->Frequency_Divider_240_248__DOT__c) 
                       & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__d) 
                          & (IData)(vlSelf->select_mode))))));
}

VL_INLINE_OPT void Vlng___024root___nba_sequent__TOP__4(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___nba_sequent__TOP__4\n"); );
    // Body
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q3 
        = ((~ (IData)(vlSelf->reset)) & (IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q2));
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q2 
        = (1U & ((~ (IData)(vlSelf->reset)) & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__ff1__DOT__q))));
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__ff1__DOT__q 
        = ((~ (IData)(vlSelf->reset)) & (IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__d1));
}

VL_INLINE_OPT void Vlng___024root___nba_comb__TOP__0(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___nba_comb__TOP__0\n"); );
    // Body
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__d1 
        = ((IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q2) 
           & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__mc_sig) 
              | (IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q3)));
}

void Vlng___024root___eval_nba(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vlng___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vlng___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((0x10ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vlng___024root___nba_sequent__TOP__2(vlSelf);
    }
    if ((8ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vlng___024root___nba_sequent__TOP__3(vlSelf);
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vlng___024root___nba_sequent__TOP__4(vlSelf);
    }
    if ((0xcULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vlng___024root___nba_comb__TOP__0(vlSelf);
    }
}

void Vlng___024root___eval_triggers__act(Vlng___024root* vlSelf);

bool Vlng___024root___eval_phase__act(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<5> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vlng___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vlng___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vlng___024root___eval_phase__nba(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vlng___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__ico(Vlng___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__nba(Vlng___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__act(Vlng___024root* vlSelf);
#endif  // VL_DEBUG

void Vlng___024root___eval(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VicoIterCount;
    CData/*0:0*/ __VicoContinue;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VicoIterCount = 0U;
    vlSelf->__VicoFirstIteration = 1U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        if (VL_UNLIKELY((0x64U < __VicoIterCount))) {
#ifdef VL_DEBUG
            Vlng___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("Frequency_Divider_240_248.v", 1, "", "Input combinational region did not converge.");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (Vlng___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelf->__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vlng___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("Frequency_Divider_240_248.v", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vlng___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("Frequency_Divider_240_248.v", 1, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vlng___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vlng___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vlng___024root___eval_debug_assertions(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->freq_in & 0xfeU))) {
        Verilated::overWidthError("freq_in");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((vlSelf->select_mode & 0xfeU))) {
        Verilated::overWidthError("select_mode");}
}
#endif  // VL_DEBUG
