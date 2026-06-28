// Shared showcase body (reinforcement learning). No `#show: scholia` here — the
// entry files (demo.typ, dark.typ, book.typ, double.typ) apply it with different
// options, then `#include` this. One body, every option exercised → visual tests.
#import "../src/lib.typ": *

#cover(
  "Value, Iterated",
  subtitle: "Notes on MDPs, the Bellman operator, and why value iteration converges",
  author: "Eric Yang",
  date: "Michaelmas, 2026",
)

= The Markov Decision Process

An agent acts; the world answers with a #keyword[reward] and a new state. It never
sees the future, only samples it. The whole subject is one question: how to act so as
to maximise reward you have *not yet received*.

#note[
The picture to hold: a value is a _promise about the future_ — the total reward you
expect from a state if you act well from now on. Everything below is bookkeeping for
that one promise.
]

#definition[Markov decision process][
A tuple $(S, A, P, r, gamma)$: states $S$, actions $A$, a transition kernel
$P(s' | s, a)$, a reward $r(s, a)$, and a #keyword[discount] $gamma in [0, 1)$ that
makes far-off reward worth #fillin(width: 2.6cm) than reward now.
] <def:mdp>

The discount $gamma$ is the single knob that makes the infinite sum below converge —
keep an eye on it.

#definition[value of a policy][
For a policy $pi: S -> A$, its value is the expected discounted return
$ V^pi (s) = bb(E)_pi [ sum_(t=0)^infinity gamma^t r(s_t, a_t) | s_0 = s ]. $
The goal is $V^* (s) = max_pi V^pi (s)$ — the best promise any policy can make.
] <def:value>

#sidenote[Is the maximising $pi$ unique? The _value_ $V^*$ is; a policy attaining it
need not be. Revisit once ties appear.]
The two definitions are one statement read forwards and backwards.

= The Bellman Operator

#recall[Why must a fixed point of $T$ exist at all?]
Define the #keyword[Bellman optimality operator] $T$ on value functions by
$ (T V)(s) = max_(a in A) [ r(s, a) + gamma sum_(s') P(s' | s, a) V(s') ]. $
A value function is optimal exactly when $T$ leaves it unchanged.

#theorem[Bellman, 1957][contraction][
$T$ is a $gamma$-contraction in the sup-norm: for all $U, V$,
$ ||T U - T V||_infinity <= gamma ||U - V||_infinity. $
Hence $T$ has a unique fixed point $V^*$ (cf. @def:value), and value iteration
$V_(k+1) = T V_k$ converges to it from any start.
] <thm:contraction>

#proof[
Fix a state $s$ and bound the difference of the two maxima:
$ |(T U)(s) - (T V)(s)| <= gamma max_(s') |U(s') - V(s')|. $
#TODO[the step $|max_a f(a) - max_a g(a)| <= max_a |f(a) - g(a)|$]
Taking the max over $s$ gives the claim; uniqueness is then Banach — this is where
$gamma < 1$ earns its keep.
]

#example[value iteration, one sweep][
Two states, $gamma = 1 / 2$, start $V_0 = (0, 0)$, rewards $r = (1, 0)$ with a self-loop.
One application of $T$ from @thm:contraction gives $V_1 = $ #fillin(width: 1.8cm).
]

#yourturn[
Run a second sweep $V_2 = T V_1$ and verify the gap $||V_2 - V^*||_infinity$ shrank by a
factor of $gamma$.
#workspace(n: 3)
]

#note[
中文直觉：价值迭代之所以收敛，全靠 $gamma < 1$ 把每一步的误差按比例「压扁」。这正是
@thm:contraction 的几何意义——一个不断收缩空间的映射，只能有一个不动点。
]

#remark[
At $gamma = 1$ the contraction is lost and $V$ may diverge; episodic tasks recover
convergence by letting termination absorb the missing discount.
]
