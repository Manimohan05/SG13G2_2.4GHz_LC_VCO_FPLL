// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlng.h for the primary calling header

#include "Vlng__pch.h"
#include "Vlng___024root.h"

VL_ATTR_COLD void Vlng___024root___eval_static(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vlng___024root___eval_initial(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_initial\n"); );
    // Body
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
}

VL_ATTR_COLD void Vlng___024root___eval_final(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__stl(Vlng___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vlng___024root___eval_phase__stl(Vlng___024root* vlSelf);

VL_ATTR_COLD void Vlng___024root___eval_settle(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_settle\n"); );
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelf->__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vlng___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("Frequency_Divider_240_248.v", 1, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vlng___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__stl(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vlng___024root___stl_sequent__TOP__0(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->freq_out = vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_out;
    vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_bar_out 
        = (1U & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_out)));
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2_bar 
        = (1U & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2)));
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1_bar 
        = (1U & (~ (IData)(vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1)));
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
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__d1 
        = ((IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q2) 
           & ((IData)(vlSelf->Frequency_Divider_240_248__DOT__mc_sig) 
              | (IData)(vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q3)));
}

VL_ATTR_COLD void Vlng___024root___eval_stl(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vlng___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vlng___024root___eval_triggers__stl(Vlng___024root* vlSelf);

VL_ATTR_COLD bool Vlng___024root___eval_phase__stl(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vlng___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vlng___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__ico(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VicoTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        VL_DBG_MSGF("         'ico' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__act(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge freq_in or posedge reset)\n");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @(posedge Frequency_Divider_240_248.div4.q1 or posedge reset)\n");
    }
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @(posedge Frequency_Divider_240_248.div4.q2 or posedge reset)\n");
    }
    if ((8ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 3 is active: @(posedge Frequency_Divider_240_248.pre45.q3 or posedge reset)\n");
    }
    if ((0x10ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 4 is active: @(posedge Frequency_Divider_240_248.d or posedge reset)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vlng___024root___dump_triggers__nba(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge freq_in or posedge reset)\n");
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @(posedge Frequency_Divider_240_248.div4.q1 or posedge reset)\n");
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @(posedge Frequency_Divider_240_248.div4.q2 or posedge reset)\n");
    }
    if ((8ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 3 is active: @(posedge Frequency_Divider_240_248.pre45.q3 or posedge reset)\n");
    }
    if ((0x10ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 4 is active: @(posedge Frequency_Divider_240_248.d or posedge reset)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vlng___024root___ctor_var_reset(Vlng___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlng__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlng___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->freq_in = VL_RAND_RESET_I(1);
    vlSelf->reset = VL_RAND_RESET_I(1);
    vlSelf->select_mode = VL_RAND_RESET_I(1);
    vlSelf->freq_out = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__mc_sig = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__b = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__c = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__d = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1 = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q1_bar = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2 = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__div4__DOT__q2_bar = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q2 = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__q3 = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__d1 = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__pre45__DOT__ff1__DOT__q = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk1__DOT__d_in = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk2__DOT__d_in = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__mod7__DOT__jk3__DOT__d_in = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_out = VL_RAND_RESET_I(1);
    vlSelf->Frequency_Divider_240_248__DOT__out_stg__DOT__q_bar_out = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__freq_in__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__reset__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q1__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__div4__DOT__q2__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__pre45__DOT__q3__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__Frequency_Divider_240_248__DOT__d__0 = VL_RAND_RESET_I(1);
}
