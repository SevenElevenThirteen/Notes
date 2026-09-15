/* 中文伪粗体 */
#import "@preview/cuti:0.4.0": show-cn-fakebold
#show: show-cn-fakebold

/* 画图 */
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

/* a more friendly templete for numbering */
#import "@preview/numbly:0.1.0": numbly

/* text sizes */
#let 初号 = 42pt
#let 小初 = 36pt
#let 一号 = 28pt
#let 小一 = 24pt
#let 二号 = 21pt
#let 小二 = 18pt
#let 三号 = 16pt
#let 小三 = 15pt
#let 四号 = 14pt
#let 小四 = 12pt
#let 五号 = 10.5pt
#let 小五 = 9pt

/*
    字体设置
    Times New Roman 不支持中文
    NSimSun 新宋体
    默认小四号
*/
#set text(
    font: ("Times New Roman", "NSimSun"),
    size: 小四
)

/*
    页面设置
    A4
    页边缘：上下 2.54cm；左右 1.91cm
*/
#set page(
    paper: "a4",
    margin: (x: 2.54cm, y: 1.91cm), 
    numbering: "1"
)

#page(numbering: none)[
    #align(center + horizon)[

        #text(size: 80pt, font: "Old English Text MT")[
            #set par(spacing: 40pt)
            
            Analytic

            Combinatorics
        ]

        #v(1em)
        #text(size: 40pt, tracking: 5pt, font: "Old English Text MT")[
            1001
        ]

        #v(6em)
        #text(size: 20pt, font: "Old English Text MT")[
            #datetime.today().display()
        ]
    ]
]
#counter(page).update(1)

#let prefixs = ("Part", "Chapter", "Section")
#set heading(numbering: (..arr) => { // type(arr) is argument; Or can also use numbly to replace all these stuffs !
    arr = arr.pos() // .pos() captures positional arguments

    if arr.len() == 1 {
        return [
            #set text(size: 三号, font: "Old English Text MT")
            #prefixs.at(0)
            #numbering("A.", arr.at(0))
        ]
    }
    if arr.len() == 2 {
        return [
            #set text(size: 三号, font: "Old English Text MT")
            #prefixs.at(1)
            #numbering("1.", arr.at(1))]
    }
    if arr.len() == 3 {
        return [ // at most 3, since outline.depth = 3
            #set text(size: 三号, font: "Old English Text MT")
            #prefixs.at(2)
            #numbering("1.", arr.at(1), arr.at(2))
        ]
    }
    return []
})

#set align(center)
#text(size: 四号)[
    #outline(
        title: [
            #v(0.5em)
            #text(size: 初号, font: "Old English Text MT")[Contents]
            #v(1em)
        ],
        indent: n => n * 1em,
        depth: 4 // only Part, Chapter & Section will display
    )
]

#pagebreak()
#counter(page).update(1)
#set align(start)

#show heading: it => {
    let arr = counter(heading).get()
    
    if it.level == 1 {
        page()[
            #set align(center + horizon)
            #set text(size: 初号)

            #text(font: "Old English Text MT")[ #prefixs.at(0) #numbering("A.", arr.at(0)) ]
            #v(1em)
            #it.body
        ]
    }
    else if it.level == 2 {
        align(center)[
            #set text(size: 一号)
            #set par(spacing: 15pt)

            #text(font: "Old English Text MT")[ #prefixs.at(1) #numbering("1.", arr.at(1)) ]

            #it.body
            #divider()
        ]
    }
    else if it.level == 3 [
        #set text(size: 小二)
        #text(font: "Old English Text MT")[
            #prefixs.at(2) #numbering("1.", arr.at(1), arr.at(2))
        ]
        #it.body
    ]
    else [
        #set text(size: 小三)
        #it.body
    ]
}

#let class(x) = {
    math.cal(x)
}
#let rm(x) = {
    math.bold(math.upright(x))
}
#let dot = math.bullet.op

#let seq = "SEQ"
#let sets = "SET"
#let pset = "PSET"
#let mset = "MSET"
#let cyc = "CYC"
#let eps = math.epsilon.alt

#let imply = math.arrow.r.double
#let iso = math.tilde.equiv // isomorphism

#let en = math.space.en
#let quad = math.space.quad

#let dcases(..args) = math.cases(..args.pos().map(math.display), ..args.named())

= Symbolic Methods

== Combinatorial Structures and OGFs

=== Definitions

*Combinatorial Class (Class)*: A set with a size function\
+ set $class(A)$ can be finite or countable infinite. 至多可数有限
+ size function satisfied: #[
    - $forall e in class(A), space "size"(e) in NN$（大小是非负整数）
    - $forall s in ZZ^+, space |\{ e: "size"(e) = s \}|$ is finite.（每个大小只有有限个元素）
]

Notation: $class(A)_n = {alpha in class(A): |alpha| = n}$, $A_n = "card"(class(A)_n)$

Counting Sequence: ${A_n}$

*Isomorphic*: $class(A) iso class(B) \/ class(A) = class(B)$, iff $forall n, A_n = B_n$

*Ordinary Generating Function*: the formal power series $A(z) = sum_n A_n z^n = sum_(alpha) z^(|alpha|)$

An Admissable Construction: $class(A) = Phi(class(B)^((1)), dots.c, class(B)^((m)))$ iff $A_n$ only depends on $B_n^((1)), dots.c, B^((m))_n$

=== Constructions

==== 0&1

*Neutral Class*: $class(E) := {eps: |eps| = 0}$, $en E(z) = |class(E)|$

显然 $class(A) iso class(E) times class(A) iso class(A) times class(E)$

*Atomic Class*: $class(Z) := {alpha: |alpha| = 1}$, $en Z(z) = |class(Z)|z$

==== Basic

*Combinatorial Sum / Disjoint Union*

$class(A) = class(B) + class(C) := ({diamond} times class(B)) space union space ({square} times class(C)) quad (diamond, square in class(E))$

用假想的零体积元素标识来源，无需 $class(B) inter class(C) = emptyset$。

$|(eps, alpha)| = dcases(|alpha|_class(B) en "from" class(B), |alpha|_class(C) en "from" class(C)) quad A_n = B_n + C_n quad A(z) = B(z) + C(z)$

*Cartesian Product*

$class(A) = class(B) times class(C) := {(beta, gamma) : beta in class(B), gamma in class(C)}$

$|alpha| = |beta|_class(B) + |gamma|_class(C) quad A_n = sum B_k C_(n - k) quad A(z) = B(z) times C(z)$

*Sequence Construction*

$class(A) = seq(class(B)) := {eps} + class(B) + (class(B) times class(B)) + dots.c = {(beta_1, dots.c, beta_m): m in NN, beta_i in class(B)}$

Note: $B_0$ must be 0 to ensure finite sum. 需无大小为零的元素，但 $seq$ 会生成一个零元素 $eps$。

$|alpha| = sum |beta_i|$

$A(z) = 1 + B + B^2 + dots.c imply A(z) = 1/(1 - B(z))$

*Cycle Construction*

$class(A) = cyc(class(B)) := (seq(class(B)) without {eps}) slash rm(S)$

把序列改成有向环，即在序列基础上商去轮换等价 $rm(S)$。一般不认为有空环。

$A(z) = display(sum_(n gt.slant 1) phi(n)/n log 1/(1 - B(z^n)))$

推导见后。

*Multiset Construction*

$class(A) = mset(class(B)) := seq(class(B)) slash rm(R) iso display(product_(beta in class(B)))seq({beta})$

在序列基础上商去置换等价 $rm(R)$。

$A(z) &= display(product_(beta in class(B)) 1/(1-z^(|beta|)) = product_n ( 1/(1-z^n) )^(B_n) = exp(sum_n -B_n log (1 - z^n)))\
&= display(exp(sum_n -B_n sum_(k gt.slant 1) - ((z^n)^k)/k) = exp(sum_(k gt.slant 1) 1/k sum_n B_n (z^k)^n)) \
&= display(exp(sum_(n gt.slant 1) B(z^n)/n) = exp(B(z)/1 + B(z^2)/2 + B(z^3)/3 + dots.c))$

*Powerset Construction*

$class(A) = pset(class(B)) iso display(product_(beta in class(B)) ({eps} + {beta}))$

$A(z) &= display(product_(beta in class(B)) (1 + z^(|beta|)) = product_n (1 + z^n)^(B_n) = exp(sum_n B_n log (1 + z^n)))\
&= display(exp(sum_n B_n sum_(k gt.slant 1) (-1)^(k + 1) ((z^n)^k)/k) = exp(sum_(k gt.slant 1) ((-1)^(k + 1))/k sum_n B_n (z^k)^n))\
&= display(exp(sum_(n gt.slant 1) (-1)^(n + 1) B(z^n)/n))$

==== Restricted

*Exactly $k$ Components*

$class(B)$ 中元素大小未必相等，故由 $k$ 个元素组成不等与 $"size" = k$。

May use bivariate generating functions. Use $z$ to mark size, and use $u$ to mark components. $u$ 的次数记录元素由几个 $class(B)$ 生成。

$A_(n, k) := "card"{alpha in class(A): |alpha = n| and "component"=k}$

$A(z, u) = sum_(n, k) A_(n, k) z^n u^k quad A_(=k)(z) = [u^k] A(z, u)$

- #[
    $class(A) = seq_(=k)(class(B))$: $A(z) = B^k (z)$

    Obvious.
]

- #[
    $class(A) = cyc_(=k)(class(B))$

    考虑 $class(S) = seq_(gt.slant 1)(class(B)) en imply en S(z, u) = (u B(z))/(1 - u B(z))$
    
    任意一个序列都可视为最小循环节的重复，另考虑所有最小循环节序列的集合 $class(P S)$（primitive sequence）。于是 $S(z, u) = sum_(n gt.slant 1) P S(z^n, u^n)$，其中 $n$ 为循环次数。

    由莫比乌斯反演，$S(z, u) = display(sum_(n gt.slant 1) P S(z^n, u^n) imply P S(z, u) = sum_(n gt.slant 1) mu(n) S(z^n, u^n))$

    从序列到环，每个 primitive cycle 的任意移位均是合法的 primitive sequence。同理记为 $class(P C)$，则 $ P C_n = n P S_n imply P C(z, u) = display(integral_0^u 1/v space P S(z, v) space upright(d)v = sum_(n gt.slant 1) mu(n)/n log 1/(1 - u^k B(z^k))) $

    最后任意环亦都可有某个最小循环节复制而得。于是 $A(z) = display(sum_(n gt.slant 1) P C (z^n, u^n))$

    由 $sum_(d | n) mu(d)/d = phi(n)/n$ 得
    $A(z, u) = display(sum_(n gt.slant 1) phi(n)/n log 1/(1 - u^n B(z^n)))$
]

- #[
    $class(A) = mset_(=k)(class(B))$

    $seq({beta}) en imply en B_beta (z, u) = display(1 + u z^(|beta|) + 1 + u^2 z^(2|beta|) + dots.c = 1/(1 - u z^(beta)))$

    $A(z, u) &= product_(beta) B_beta (z, u) = product_n (1/(1 - u z^n))^(B_n)\
    &= display(exp(sum_(n gt.slant 1) u^n/n B(z^n))) = display(exp(u/1 B(z) + u^2/2 B(z^2) + u^3/3 B(z^3) + dots.c))$
]

- #[
    $class(A) = pset_(=k)(class(B))$

    ${eps} + {beta} en imply en B_beta (z, u) = 1 + u z^(|beta|)$

    $A(z, u) &= product_beta B_beta (z, u) = product_n (1 + u z^n)^(B_n)\
    &= display(exp(sum_(n gt.slant 1) (-1)^(n + 1) u^n/n B(z^n)) = exp(u/1 B(z) - u^2/2 B(z^2) + u^3/3 B(z^3) - dots.c))$
]

==== Additional Constructions

*Pointing*

$Theta class(B) := sum class(B)_n times {eps_1, dots.c, eps_n}$

$class(A) = Theta class(B) en imply en A_n = n B_n en imply en A(z) = z partial_z B(z)$, where use $partial_z$ to denote $upright(d)/(upright(d)z)$.

*Substitution*

$class(B) compose class(C) en slash en class(B)[class(C)] := sum class(B)_k times seq_(=k)(class(C))$

$class(A) = class(B) compose class(C) en imply en A(z) = sum B_k (C(z))^k = B(C(z))$

==== Solving From Implicit Specifications

- #[
    $class(A) = class(B) + class(X) slash class(B) times class(X) slash seq(class(X))$

    évident.
]

- #[
    $class(A) = mset(class(X))$

    $display(X(z) = sum mu(k)/k log A(z^k))$
]

=== Applications

==== Integer Compositions & Partitions

For an integer $n in NN$, assume $n = x_1 + dots.c + x_k space (forall x_i gt.slant 1)$, then define:
- *Composition*: sequence $(x_1, dots, x_k)$（区分顺序）
- *Partition*: sequence $(x_1, dots, x_k)$, where $x_1 gt.slant dots.c gt.slant x_k$

#divider()

Atomic Class: $ class(Z) &= \{dot\} \ imply Z &= z $

Integers that at least 1: $ class(I) &= \{dot, dot dot, dots.c\} iso seq(class(Z))_(gt.slant 1) \ imply I &= z/(1-z) \ I_n &= 1 $\

Assume $class(T) subset class(I)$, and $T = \{ |e|: e in class(T) \} subset NN$

#divider()

Compositions:
- All
$ class(C) &= seq(I) \ imply C &= 1/(1 - I) = (1 - z)/(1 - 2z) \ &= (sum_(k) 2^n z^n) - z(sum_(k) 2^n z^n) = 1 + sum_(k gt.slant 1) (2^n - 2^(n - 1))z^n \ &= 1 + sum_(k gt.slant 1) 2^(n - 1)z^n \ C_n &= 2^(n - 1) quad C_0 = 1 $
- Based on $class(T)$
$ class(C)^class(T) &= seq(seq_class(T)(class(Z))) \ imply C^class(T) &= 1/(1 - sum_(n in T) z^n) = 1/(1 - T(z)) $
- Only use numbers $lt.slant r$: #en $class(T) = \{1, dots, r\}$
$ class(C)^(\{1, dots.c, r\}) &= seq(seq_(1, dots.c, r)(class(Z))) \ imply C^(\{1, dots.c, r\}) &= 1/(1 - z - dots.c - z^r) = (1 - z)/(1 - 2z + z^(r + 2)) $
- Exactly $k$ parts:
$ class(C)^((k)) &= class(I)^k \ imply C^((k)) &= (z^k)/((1 - z)^k) $
- Cyclic:（商掉循环同构）$class(C)^("CYC") = cyc(class(I))$

#divider()

Partitions:
- All: #en no explicit formula !
$ class(P) &= mset(I) \ imply P &= product_(k gt.slant 1) 1/(1 - z^k)^(I_k) = product_(k gt.slant 1) 1/(1 - z^k) $
- Based on $class(T)$
$ class(P)^class(T) &= mset(seq_(class(T))(class(Z))) \ imply P^class(T) &= product_(n in T) 1/(1 - z^n) $
- Only use numbers $lt.slant r$: #en $class(T) = \{1, dots, r\}$
$ class(P)^(\{1, dots.c, r\}) &= mset(seq_(1, dots.c, r)(class(Z))) \ imply P^(\{1, dots.c, r\}) &= product_(n = 1)^(r) 1/(1 - z^n) $
- At most $k$ parts: 对任意一种拆分，转而对每种值 $v$ 记录 $gt.slant v$ 的数的个数。二者一一对应。
$ class(P)^((lt.slant k)) &iso class(P)^(\{1, dots.c, k\}) \ imply P^((lt.slant k)) &= product_(n = 1)^(k) 1/(1 - z^n) $

==== Words & Regular Languages

Letters: a finite alphabet $class(A)$, where all letters has the same size 1.\
Word: a finite sequence of letters.\
$class(W) \/ class(A)^ast$: the set of all words.\
Language: a subset of $class(W)$

$ class(W) iso seq(class(A)) en imply en W(z) = 1/(1 - |class(A)|z) $

#divider()

*Regular Language*: construction only involve atoms ($class(A)$) and  $+, times, seq$\
A *S-regular* Language $class(L)$: iff exist a regular language $class(M)$ s.t. $class(L) iso class(M)$. $en$ (S for Specification)

$imply$ the OGF of a S-regular language $class(L)$ is always a rational funtion! 生成函数总是有理

- #[
    记 $class(A) = {mono(0), mono(1)}$，考虑所有不含 $mono(11)$ 的字符串集合 $class(L)$。现有一个长为 $n$ 的 01 串，希望加密为 $class(L)$ 中的字符串发送并可解密，最小化加密后的串长。

    $class(L) = mono(0) times class(L) + mono(01) times class(L) en imply en L = z L + z^2 L en imply en L = 1/(z^2 + z - 1)$ 为斐波那契的 OGF！

    $|class(A)^n| = 2^n lt.slant L_m tilde phi^m en imply en m gt.slant 1/(log_2 phi) n$，因此串长下界线性，系数 #calc.round(calc.log(2) / calc.log(1.618), digits: 2)。
]

- #[
    记 $class(A) = {mono(1), mono(2)}$，求 $n$ 位01串且无连续5个0/1的字符串数量。

    $ class(L) = & seq({0, 00, 000, 0000} times {1, 11, 111, 1111}) times {epsilon, 0, 00, 000, 0000}\
    +& seq({1, 11, 111, 1111} times {0, 00, 000, 0000}) times {epsilon, 1, 11, 111, 1111}\
    imply L = & 2 times (1 + z + z^2 + z^3 + z^4)/(1 - (z + z^2 + z^3 + z^4)^2) = 2 times (1-z^5)/(1-z) times 1/(1 - (z (1-z^4)/(1-z))^2)\
    = & 2/(1 - z - z^2 - z^3 - z^4) = (2(1-z))/(1 - 2z + z^5) $
]

- #[
    记 $frak(p) = p_1p_2 dots.c p_k$ 为一字符串，包含 $frak(p)$ 为子序列的字符串：
    $ class(L) = seq(class(A) \/ p_1) times p_1 times seq(class(A) \/ p_2) times dots.c times seq(class(A) \/ p_k) times p_k times seq(class(A)) $
    consider the left-most occurence of $frak(p)$.
]

#divider()

*Finite Automaton*: state $Q$, include a initial state $q_0 in Q$ and a set of final states $overline(Q) subset Q$. States are vertics, and edges are labelled with letters by alphabet $class(A)$.\
A *Deterministic* finite automaton: iff $forall q in Q, alpha in class(A)$, $q$ has at most 1 edge labelled with $alpha$.\
A *A-Regular* Language: iff exist a deterministic finite automaton accept all words from $class(L)$.(or $class(L) iso class(M)$, where $class(M)$ is a A-regular language.) $en$ (A for Automaton)

Note: Let $class(L)$ be the binary representations of all primes. $class(L)$ is neither S-regular nor A-regular!

*Theorem*. Equivalence Theorem.\
A language is S-regular iff it is A-regular. S 正则等价于 A 正则，证明是非平凡的。

#divider()

*OGF of $class(L)$ of all words accepted by the automaton*

Define the transition matrix *T* be $T_(i, j) = |{alpha: exists q_i arrow.r^alpha q_j}|$. 即 $i arrow.r j$ 的有向边数。

记 *u*$=(1, 0, dots.c, 0)$，*v*$=(v_0, dots.c, v_s)$，其中 $v_i = [q_j in overline(Q)]$（标示每个状态是否为终止）

$ imply L(z) = bold(upright(u)) space (I - z T)^(-1) space bold(upright(v)) $

证明：记 $class(L)_k$ 为所有从 $q_j$ 出发并被接收的字符串。考虑出边，则 $class(L)_k iso Delta_j + (sum {alpha} class(L)_{q_j compose alpha})$，其中 $Delta_j$ 视 $q_j$ 是否为终止节点而为 ${epsilon}$（空串）或 $emptyset$。于是 $L_k = [q_j in overline(Q)] + z sum L_(q_j compose alpha) en imply en rm(L) = rm(v) + z T rm(L)$，而所求为 $rm(L)_0$。

#divider()

- #[
    Autocorrelation: 自相似，border.\
    *Autocorrelation Vector*: consider a pattern $frak(p) = p_1 dots.c p_k$, define vector $rm(c) = (c_0, dots.c, c_(k - 1))$, where
    $c_i = [p_(i + 1) dots.c p_k space = space p_1 dots.c p_(k - i)]$.
    即 $frak(p)$ 右移 $i$ 位后与原串是否对应相等 a.k.a. $frak(p)$ 有长为 $k - i$ 的 border / period.

    *Autocorrelation Polynomial*: $c(z) := sum_(t = 0)^(k - 1) c_t z^t$

    考虑 $class(S)$ 为所有不含 $frak(p)$ 的字符串集合，又记 $class(T)$ 为 $frak(p)$ 出现且仅出现在末尾的字符串集合。试在 $class(S)$ 后追加一字符，新字符串或出现 $frak(p)$ 而存于 $class(T)$，或不出现 $frak(p)$ 而仍在 $class(S)$，故：
    $ class(S) + class(T) = {epsilon.alt} + class(S) times class(A) $
    另一方面，考虑在 $class(S)$ 后追加 $frak(p)$。由于 border，后缀未必是 $frak(p)$ 的首次出现，但不难看出必然是 $class(T)$ 后接一小段 border。易知是双射，于是
    $ class(S) times {frak(p)} = class(T) times sum_(c_i eq.not 0) {p_(k - i + 1) dots.c p_k} $

    综上，
    $ cases(display(S + T &= 1 + |class(A)|z S), display(z^k S &= c(z) T)) en imply en cases(S = display(c(z)/(z^k + (1 - |class(A)|z)c(z))), T = display(z^k/(z^k + (1 - |class(A)|z)c(z)))) $

    而所有包含 $frak(p)$ 的字符串集合 $class(L) = class(T) times seq(class(A))$
]

- #[
    Word Encoding & Set Partitions

    Stirling numbers of the second kind, a.k.a. Stirling partition numbers, is denoted as $mat(delim: "{", n; k)$, meaning to divide ${1, dots.c, n}$ into $k$ sets regardless of the order of sets. 第二类斯特拉数。

    考虑指定一个顺序。把每个集合内的数从小到大排序，并且把最小数作为关键字对集合排序。又考虑一个 $k$ 个字母的字母表 $class(A)$，不妨规定字典序 $a_1 < dots.c < a_k$。排序后的第 $i$ 个集合中的数均用 $a_i$ 标记，则 $(1, 2, dots.c, n)$ 对应了一个字符串。

    记 $class(S)_n^k$ 为所有划分的集合，记 $class(T)_n^k$ 为所有长度为 $n$ 并满足如下两条性质的字符串集合：$a_1, dots.c, a_k$ 均出现；$a_1, dots.c, a_k$ 首次出现位置递增。易知为双射，于是
    $ class(S)_n^k iso class(T)_n^k $
    而 $ union.big_n class(T)_n^k = &{a_1} times seq({a_1}) times {a_2} times seq({a_!, a_2}) times dots.c \
    &times {a_t} times seq({a_1, dots.c, a_t}) times dots.c\
    &times {a_n} times seq({a_1, dots.c, a_k}) $

    于是 $ S^((k)) =  T^((k)) &= display(z^k/((1 - z)(1 - 2z) dots.c (1 - k z))) \
    &= 1/k! sum_(t = 0)^(k) binom(k, t) ((-1)^(k - t))/(1 - t z)\
    mat(delim: "{", n; k) = S_n^k &= 1/k! sum_(t = 1)^k (-1)^(k - t) binom(k, t) t^n $
]

==== Tree Structures

*Plane Trees*: plane means we can draw the tree on the graph, where all sons are listed from left to right. 儿子记顺序。

If all out-degree of node are constrained to lie in $Omega$, then define
$ phi.alt(u) := sum_(omega in Omega) u^omega $

For all rooted trees $class(T)^Omega$, $ class(T)^Omega = class(Z) times seq_(Omega)(class(T)^Omega) en imply en T^Omega = z times phi.alt(T^Omega) $

Therefore, $z = display(T^Omega/(phi.alt(T^Omega)))$. Form Lagrange Inversion Thorem, 
$ [z^n]T(z) = 1/n [u^(n - 1)] phi.alt(u)^n $

Furthermore, $Omega$ can be a multiset. e.g. same degree but with different colour.

#divider()

*Non-plane Trees*: still rooted 但不计儿子顺序

== Labelled Structures and EGFs

=== Definitions

*Weakly Labelled*: an object of size $n$, each vertex has a labelled

*Well-Labelled*: an object of size $n$, iff it's weakly labelled, and its collection of labels is exactly ${1, dots.c, n}$

*Labelled Class*: a combinatorial class (same as in Chapter 1) comprised of well-labelled objects.

*Exponential Generating Function*: $A(z) := display(sum_(n gt.slant 0) A_n z^n/n! = sum_(alpha) z^(|alpha|)/(|alpha|!))$

$A_n = n! times [z^n] A(z)$

=== Constructions

==== 0 & 1

- #[
    $class(E) = {eps} en E(z) = 1$
]

- #[
    $class(Z) = {1} en Z(z) = z$
]

==== Basic & Restricted

Binomial Convolution

$a(z) = b(z) times c(z) en imply en a_n = display(sum binom(n, k) b_k c_(n - k))$

$a(z) = b_1(z) times dots.c times b_m (z) en imply en a_n = display(sum_(k_1 + dots.c k_m = n) binom(n, k_1, dots.c, k_m) b_(1, k_1) times dots.c times b_(m, k_m))$

这里多项式乘法为常义乘法，而对应到系数上为二项式卷积。

Reduction: $rho(alpha)$ 将 $alpha$ 的标号更换至 ${1, dots.c, n}$，保持相对顺序。

Expansion: $e(alpha)$ 将 ${1, dots.c, n}$ 编号的 $alpha$ 更换为更大的编号，保持相对顺序。

Labelled Product: take $beta in class(B), gamma in class(C)$, define:
$ beta star gamma &:= {(beta', gamma'): (beta', gamma') "is well-labelled", rho(beta') = beta, rho(gamma') = gamma}\
&:= {(e(beta), f(gamma)): "Im"(e) inter "Im"(f) = emptyset, "Im"(e) union "Im"(f) = {1, dots.c, |beta| + |gamma|} $

$beta star gamma$ 即把 ${1^square, dots.c, |beta|^square}$ 和 ${1^diamond, dots.c, |gamma|^diamond}$ 合并为长 $|beta| + |gamma|$ 的所有序列的集合。

#divider()

*Labelled Product*

$class(B) times class(C) := display(union.big_(beta in class(B), gamma in class(C)) (beta star gamma))$

$class(A) = class(B) star class(C) en imply en A_n = display(sum_(n_1 + n_2 = n) binom(n, n_1, n_2) B_(n_1) times C_(n_2)) en imply en A(z) = B(z) times C(z)$

易有 $class(A) times (class(B) times class(C)) = (class(A) times class(B)) times class(C) = class(A) times class(B) times class(C)$，有结合律。

*$k$-Sequences & Sequence*

$seq(class(B)) := {eps} + class(B) + (class(B) star class(B)) + dots.c = union.big seq_(k)(class(B))$

$seq_(k)(class(B)) = underbrace(class(B) star dots.c star class(B), k "times")$

$dcases(class(A) = seq_(k)(class(B)) en &imply en A(z) = B^k (z), class(A) = seq(class(B)) en &imply en A(z) = sum_(k gt.slant 0) B^k (z) = 1/(1 - B(z)))$

Require $class(B)_0 = emptyset$

*$k$-Sets & Set*

$sets_(k)(class(B)) = seq_(k)(class(B)) slash rm(R)$, where $rm(R)$ is a equivalence relation.
Each set is counted $k!$ times as a sequence, regardless of the size.

$sets(class(B)) = {eps} + class(B) + sets_(2)(class(B)) + dots.c = union.big sets_(k)(class(B))$

$dcases(class(A) = sets_(k)(class(B)) en &imply en A(z) = 1/k! B^k (z), class(A) = sets(class(B)) en &imply en A(z) = sum_(k gt.slant 0) 1/k! B^k (z) = exp(B(z)))$

*$k$-Circles & Circle*

$cyc_(k)(class(B)) = seq_(k)(class(B)) slash rm(S)$, where $rm(S)$ is a equivalence relation.
Fix the circle by its smallest element, say $1$, then each circle is counted $k$ times as a sequence. All cyclical shifts are same.

$cyc(class(B)) = cyc_(1)(class(B)) + cyc_(2)(class(B)) + dots.c = union.big_(k gt.slant 1) cyc_(k)(class(B))$

$dcases(class(A) = sets_(k)(class(B)) en &imply en A(z) = 1/k B^k (z), class(A) = sets(class(B)) en &imply en A(z) = sum_(k gt.slant 1) 1/k B^k (z) = log 1/(1 - B(z)))$

==== Additional Constructions

Pointing and substitution are same as unordered ones.

*Pointing*

$Theta class(B) := sum class(B)_n times {1, 2, dots.c, n}$

$class(A) = Theta class(B) en imply en A_n = n B_n en imply en A(z) = z partial_z B(z)$, where use $partial_z$ to denote $upright(d)/(upright(d)z)$.

*Substitution*

$class(B) compose class(C) en slash en class(B)[class(C)] := sum class(B)_k times sets_(k)(class(C))$

$class(A) = class(B) compose class(C) en imply en A(z) = sum B_k (C(z))^k = B(C(z))$

*Order Constraints*

$class(A) = (class(B)^square star class(C))$: the element with the smallest label of $beta star gamma$ must comes from $class(B)$.

$A_n = display(sum_(k = 1)^n binom(n - 1, k - 1) B_k C_(n - k) = sum_(k = 1)^n k/n binom(n, k) B_k C_(n - k) = 1/n sum_(k = 0)^n (k B_k) C_(n - k))\
imply n A_n = display(sum_(k = 0)^n (k B_k) C_(n - k)) imply z partial_z A(z) = (z partial_z B(z)) times C(z) imply upright(d)/(upright(d)z) A(z) = C(z) times upright(d)/(upright(d)z) B(z)$

$display(A(z) = integral_(0)^(z) (partial_t B(t)) times C(t) en upright(d) t)$