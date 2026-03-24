// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vlng__pch.h"

//============================================================
// Constructors

Vlng::Vlng(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vlng__Syms(contextp(), _vcname__, this)}
    , freq_in{vlSymsp->TOP.freq_in}
    , reset{vlSymsp->TOP.reset}
    , select_mode{vlSymsp->TOP.select_mode}
    , freq_out{vlSymsp->TOP.freq_out}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vlng::Vlng(const char* _vcname__)
    : Vlng(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vlng::~Vlng() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vlng___024root___eval_debug_assertions(Vlng___024root* vlSelf);
#endif  // VL_DEBUG
void Vlng___024root___eval_static(Vlng___024root* vlSelf);
void Vlng___024root___eval_initial(Vlng___024root* vlSelf);
void Vlng___024root___eval_settle(Vlng___024root* vlSelf);
void Vlng___024root___eval(Vlng___024root* vlSelf);

void Vlng::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vlng::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vlng___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vlng___024root___eval_static(&(vlSymsp->TOP));
        Vlng___024root___eval_initial(&(vlSymsp->TOP));
        Vlng___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vlng___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vlng::eventsPending() { return false; }

uint64_t Vlng::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vlng::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vlng___024root___eval_final(Vlng___024root* vlSelf);

VL_ATTR_COLD void Vlng::final() {
    Vlng___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vlng::hierName() const { return vlSymsp->name(); }
const char* Vlng::modelName() const { return "Vlng"; }
unsigned Vlng::threads() const { return 1; }
void Vlng::prepareClone() const { contextp()->prepareClone(); }
void Vlng::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void Vlng::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'Vlng::trace()' called on model that was Verilated without --trace option");
}
