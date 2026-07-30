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
        depth: 3 // only Part, Chapter & Section will display
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
#let dot = math.bullet.op

#let seq = "SEQ"
#let pest = "PEST"
#let mset = "MSET"
#let cyc = "CYC"

#let imply = math.arrow.r.double
#let iso = math.tilde.equiv // isomorphism

#let rm(x) = {
    math.bold(math.upright(x))
}

#let en = math.space.en
#let quad = math.space.quad

= Symbolic Methods

== Combinatorial Structures and OGFs

=== Definations

*Combinatorial Class (Class)*: A set with a size function\
+ set $class(A)$ can be finite or countable infinite. 至多可数有限
+ size function satisfied: #[
    - $forall e in class(A), space "size"(e) in NN$（大小是非负整数）
    - $forall s in ZZ^+, space |\{ e: "size"(e) = s \}|$ is finite.（每个大小只有有限个元素）
]

=== Constructions

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

$ class(W) iso seq(class(A)) en imply en W(z) = 1/(1 - |sum|z) $

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
    = & 2/(1 - z - z^2 - z^3 - z^4) $
    对吗？
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

