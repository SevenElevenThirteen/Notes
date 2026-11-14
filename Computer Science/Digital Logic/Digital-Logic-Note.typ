/* packages */
#import "../../__Template/Typst-Template/Packages-for-Typst-Template.typ": *
#show: environment

/* abbrs */
#import "../../__Template/Typst-Template/Abbrs-for-Typst-Template.typ": *
#let proof = proof-template.with(prefix: [证明：]) // more recommended by GPT 5.6 Luna, and get ce when try to use set/show
#show figure.caption: it => {it.body}

/* Circuit */
#import "@preview/zap:0.6.0"
#import "@preview/fletcher:0.5.8": diagram as fletcher-diagram, node as fletcher-node, edge as fletcher-edge
#let ieee-circuit(body) = zap.circuit({ // use IEEE style
    import zap: *
    set-style(variant: "ieee")
    body
})
#let state-graph(zero-zero, zero-one, one-zero, one-one) = {
    figure(
        fletcher-diagram(
            node-shape: circle,
            node-stroke: black,
            node-fill: white,
            edge-stroke: 0.8pt,
            spacing: (10em, 4em),
            fletcher-node((0, 0), [$0$]),
            fletcher-node((1, 0), [$1$]),
            fletcher-edge((0, 0), (0, 0), marks: "->", bend: 120deg, loop-angle: 180deg, label: zero-zero, label-angle: 0deg),
            fletcher-edge((0, 0), (1, 0), marks: "->", bend: 30deg, label: zero-one),
            fletcher-edge((1, 0), (0, 0), marks: "->", bend: 30deg, label: one-zero),
            fletcher-edge((1, 0), (1, 0), marks: "->", bend: 120deg, loop-angle: 0deg, label: one-one, label-angle: 0deg),
        )
    )
}
// #let tri-state(name, ..args) = {
//   let position = args.pos().at(0)

//   let draw(ctx, positions, style) = {
//     let w = 1.6
//     let h = 1.0

//     interface(
//       (-w / 2, -h / 2),
//       (w / 2, h / 2),
//       io: false,
//     )

//     cetz.draw.merge-path(
//       fill: style.fill,
//       stroke: style.stroke,
//       close: true,
//       {
//         line((-w / 2, -h / 2), (-w / 2, h / 2))
//         line((-w / 2, h / 2), (w / 2, 0))
//         line((w / 2, 0), (-w / 2, -h / 2))
//       },
//     )

//     cetz.draw.anchor("in", (-w / 2, 0))
//     cetz.draw.anchor("out", (w / 2, 0))
//     cetz.draw.anchor("enable", (0, -h / 2))
//   }

//   symbol("tri-state", name, draw: draw, ..args)
// }

/* 卡诺图 by ds v4.1 flash */
#import "karnaugh.typ": kmap

/* specific math abbr. */
#let ne(x) = math.overline(x)

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

        #text(size: 40pt)[
            #set par(spacing: 40pt)
            
            Digital Logic
        ]

        #v(1em)
        #text(size: 20pt)[
            1001
        ]

        #v(6em)
        #text(size: 20pt)[
            #datetime.today().display()
        ]
    ]
]
#counter(page).update(1)

#set heading(numbering: "A.a.1.")

#set align(center)
#text(size: 四号)[
    #outline(
        title: [
            #v(0.5em)
            #text(size: 初号)[Contents]
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
        pagebreak(weak: true)
        set align(center)
        set text(size: 初号)
        it
        v(1em)
    }
    else if it.level == 2 {
        // set align(center)
        set text(size: 二号)
        it
    }
    else if it.level == 3 {
        it
    }
    else {
        it.body
    }
}

= 基础

== 二进制系统

连续量 vs 离散量

取值 ${0, 1}$ 的离散量称开关量，或比特 bit。bit 的组合称“码”。表零一的电平称逻辑电平。

一般地，1 表高电平，0 表低电平，这称正逻辑体制。反之，称负逻辑体制。

数字波形：
- 正脉冲：低-高-低 / 上升沿-下降沿
- 负脉冲：高-低-高 / 下降沿-上升沿

== 数制与数码

二进制 binary；八进制 octal；十进制 decimal；十六进制 hexadecimal

- 整数：除，倒取余
- 小数：乘，正取整

编码：Binary String $arrow.r$ Binary String，不是数值的进制转换
- 自然
- #[
    二-十进制码 / BCD 码：4bit 表 0-9

    - #[
        有权码：从高到低的位权：
        - 8421
        - 5421
        - 2421：此时部分数字表示不唯一，有 A/B 两套方案
    ]
    - #[
        无权码

        - 余三码：在 8421 基础上，每个数加 0011
        - 格雷码
    ]
]
e.g. $(4.79)_(10) = (0100 space . space 0111 space 1001)_(8421"BCD")$

奇偶校验码：补一位校验码，使得 pop count 为奇数/偶数

== 逻辑函数

*基本运算*

#table(
    columns: 5,
    align: horizon + center,
    table.header(
        [运算], [符号], [IEC], [IEEE/ANSI], [GB/T]
    ),
    [与], [$A dot.c B$ / $A B$], [
        #zap.circuit({
            import zap: *
            land("", (0, 0), variant: "iec")
        })
    ], [
        #zap.circuit({
            import zap: *
            land("", (0, 0), variant: "ieee")
        })
    ], [
        #figure(
            image("images/GB-T/and-gate-gb.svg")
        )
    ],

    [或], [$A + B$], [
        #zap.circuit({
            import zap: *
            lor("", (0, 0), variant: "iec")
        })
    ], [
        #zap.circuit({
            import zap: *
            lor("", (0, 0), variant: "ieee")
        })
    ], [
        #figure(
            image("images/GB-T/or-gate-gb.svg")
        )
    ],

    [非], [$overline(A)$], [
        #zap.circuit({
            import zap: *
            lnot("", (0, 0), variant: "iec")
        })
    ], [
        #zap.circuit({
            import zap: *
            lnot("", (0, 0), variant: "ieee")
        })
    ], [
        #figure(
            image("images/GB-T/not-gate-gb.svg")
        )
    ],

    [与非], [$overline(A dot.c B)$], [
        #zap.circuit({
            import zap: *
            lnand("", (0, 0), variant: "iec")
        })
    ], [
        #zap.circuit({
            import zap: *
            lnand("", (0, 0), variant: "ieee")
        })
    ], [
        #figure(
            image("images/GB-T/nand-gate-gb.svg")
        )
    ],

    [或非], [$overline(A + B)$], [
        #zap.circuit({
            import zap: *
            lnor("", (0, 0), variant: "iec")
        })
    ], [
        #zap.circuit({
            import zap: *
            lnor("", (0, 0), variant: "ieee")
        })
    ], [
        #figure(
            image("images/GB-T/nor-gate-gb.svg")
        )
    ],

    [异或], [$A xor B$], [
        #zap.circuit({
            import zap: *
            lxor("", (0, 0), variant: "iec")
        })
    ], [
        #zap.circuit({
            import zap: *
            lxor("", (0, 0), variant: "ieee")
        })
    ], [
        #figure(
            image("images/GB-T/xor-gate-gb.svg")
        )
    ],

    [同或], [$A dot.o B$], [
        #zap.circuit({
            import zap: *
            lxnor("", (0, 0), variant: "iec")
        })
    ], [
        #zap.circuit({
            import zap: *
            lxnor("", (0, 0), variant: "ieee")
        })
    ], [
        #figure(
            image("images/GB-T/xnor-gate-gb.svg")
        )
    ],
)

*三态门*

输出 0 / 1 / 高阻态。

使能端有效时（1），输出取决于输入；使能端无效时（0），输出恒为高阻态。

== 布尔代数

*运算律*：
- #[
    $dot$ 对 $times$ 分配，$times$ 对 $dot$ 分配。
]

- #[
    De Morgan's

    $ne(sum A) = sum ne(A) wide ne(product A) = product ne(A)$
]
- #[
    吸收

    $A + A dot B = A dot (1 + B) = A$

    $A + ne(A) dot B = (A + ne(A)) dot (A + B) = A + B$

    $A B + ne(A)C + B C = A B + ne(A)C$，推广 $A B + ne(A)C + B C D dots.c = A B + ne(A) C$

    $A dot (A + B) = A + A dot B = A$

    $(A + B) dot (A + C) = A + B dot C$

]

*规则*：
- #[
    代入
]

- #[
    反演：De Morgan's 的扩展

    $F to ne(F)$：先 $dot to +$，后 $+ to dot$，再 $0 to 1 en 1 to 0 en A to ne(A) en ne(B) to B$。这里 $A, B$ 均为最小变量，跨域多个变量的长取非不变。

    e.g. $A dot ne(B + C) + C D med to med (ne(A) + ne(ne(B) dot ne(C))) dot (ne(C) + ne(D))$
]
- #[
    对偶：$A equiv B iff A' equiv B'$，或，一个等式的对偶式亦成立

    $F to F'$：先 $dot to +$，后 $+ to dot$，再 $0 to 1 en 1 to 0$。
]

*转换*：用还原律 $A to ne(ne(A))$，配合 De Morgan's
- #[
    与或式：$product + product + dots.c + product$

    或与式展开括号。

    $A ne(B) + B ne(C)$
]

- #[
    或与式：$sum times sum times dots.c times sum$

    与或式两次取反，两次展开。

    $ne(ne(A ne(B) + B ne(C))) &= ne((ne(A) + B) dot (ne(B) + C)) = ne(ne(A) thin ne(B) + ne(A)C + B C) = ne(ne(A) thin ne(B) + B C)\
    &= (A + B)(ne(B) + ne(C))$
]
- #[
    *与*非式：只使用与非门；在*与*或式上两次取反，一次展开。

    $ne(ne(A ne(B) + B ne(C))) = ne(ne(A ne(B)) dot ne(B ne(C)))$
]
- #[
    *或*非式：只使用或非门；在*或*与式上两次取反，一次展开。

   $ne(ne((A + B)(ne(B) + ne(C)))) = ne(ne(A + B) + ne(ne(B) + ne(C)))$
]
- #[
    与或非式：外层套一个长取反；在或非式上，内层取反下传

    $ne(ne(A + B) + ne(ne(B) + ne(C))) = ne(ne(A) thin ne(B) + B C)$
]

== 卡诺图

==== 最小项

相邻最小项：$n-1$ 个变量相同，另一个 $A$ 和 $ne(A)$

==== 卡诺图

将 $n$ 变量的 $2^n$ 个最小项排成循环矩阵，使得相邻最小项 $iff$ 相邻方格。为此，将变量均匀分配至行列，按*格雷码*排列。*行列最末两个逆序*。
四个角总是相邻！

四联通 $imply n = 4$。$n = 5$ 的卡诺图增加一条对称轴，对称方格相邻。$n geq 5$ 已不直观。

#grid(columns: 2, column-gutter: 1em, row-gutter: 1em)[
    #kmap(("A", "B"))
][
    #kmap(("A", "B", "C"))
][
    #kmap(("A", "B", "C", "D"))
]

一个任意的与项，在卡诺图上对应于一个循环连续的、大小为 $2^k$ 的矩形。\
e.g. $n = 4$，$A B med to med (11, 00)(11, 01)(11, 11)(11, 10)$

反之，一个这样的矩形可以等价地化简为一个与项。

逻辑式子化为与或式，画在卡诺图上。重新用大小为 $2^k$ 的循环矩形覆盖。允许重复覆盖，因为外层运算是或。希望最小化矩形数量。（方案不唯一，如一个长度为6的环；一般地，属于集合覆盖问题 NP-Hard）

无关项：（在实际情况下）不会出现的最小项。可以任意指定为 0/1。在卡诺图中，无关项可以辅助构建大矩形，而不需全部覆盖。

= 组合逻辑

竞争冒险：逻辑门的两个互补输入信号同时取反 $(1, 0) to (0, 1)$。由于变化难以保证同时，总分先后，可能在中间时刻输出（极短的）异常脉冲。

解决：
- #[
    选通脉冲：$E N = 1$ 时才有效。普适做法。
]
- #[
    修改设计
]

= 时序逻辑

时序逻辑电路的输出不仅取决于当前输入，还取决于电路保存的状态。它必然存在输出到输入的反馈。

p.s. 输入用 $S$ 表示高电平有效；用 $ne(S)$ 表示低电平有效。$X$ 表示任意输入。

== 锁存器

锁存器具有两个*稳定*的物理状态，可记忆 1bit。它同时输出两个互补的状态 $Q, ne(Q)$；另称 $Q = 0 slash 1$ 为 0/1 状态。

=== 基本 SR 锁存器

==== 电路图
#figure(
    image("images/基本SR锁存器.png")
)

==== 状态方程

以 (a) 为例
$ cases(Q^(n + 1) = ne(ne(S)) + ne(R)Q^n, ne(S) + ne(R) = 1) $

$ne(S) = ne(R) = 0$ 是不稳定状态，这会导致 $Q = ne(Q) = 1$。（输出是稳定的，但其本身不合法）

==== 状态转换图

#state-graph([$ne(S)=1, ne(R)=X$], [$ne(S)=0, ne(R)=1$], [$ne(S)=1, ne(R)=0$], [$ne(S)=X, ne(R)=1$])

e.g. 假设用与非门 (a) 实现，则总有 $Q' = ne(ne(S) med ne(Q)), sp ne(Q)' = ne(ne(R) med Q)$。又设当前处在 0 状态，即 $Q = 0, ne(Q) = 1$。考虑如下输入：
- #[
    $ne(S) = 0, ne(R) = 1$：\
    第一个门延迟后：$Q_1 = ne(ne(S) med ne(Q)) = ne(0 dot ne(Q)) equiv 1, quad ne(Q)_1 = ne(ne(R) med Q) = ne(1 med 0) = 1$\
    第二个门延迟后：$Q_2 equiv 1, quad ne(Q)_2 = ne(ne(R) med Q_1) = ne(1 dot 1) = 0$，此后进入 1 状态并稳定。
]
- #[
    $ne(S) = 1, ne(R) = 0$：\
    $Q_1 = ne(ne(S) med ne(Q)) = ne(1 med 1) = 0 = Q, quad ne(Q)_1 = ne(ne(R) med Q) = ne(0 dot 0) = 1 = ne(Q)$，仍处于 0 状态。
]

总而言之，无论重置或保持，总要制造恒等式。
若起重置作用，$S slash R$ 中恰有一个短路原状态，稳定需要两个门延迟；若仅保持原状，$S, R$ 均被短路。

// ==== 驱动表

// #table(
//   columns: 4,
//   align: horizon + center,
//   table.header([$Q^(n+1)$], [$Q^(n)$], [$S$], [$R$]),
//   [0], [0], [0], [X],
//   [0], [1], [1], [0],
//   [1], [0], [0], [1],
//   [1], [1], [X], [0],
// )

=== 门控 SR 锁存器

在基本 SR 锁存器前加入使能 $E$。$E=0$ 时输入被屏蔽并保持；$E=1$ 时按 SR 锁存器工作。通过使能端屏蔽不稳定状态。

==== 电路图

#figure(
    image("images/gated-sr-latch-nand.svg", width: 85%),
    caption: [门控 SR 锁存器（NAND 实现）],
)

==== 状态方程

在 $E = 1$ 状态下
$ cases(Q^(n + 1) = S + ne(R) Q^n, S R = 0) $

==== 状态转换图

#state-graph(
    [$E = 0$],
    [$E = 1 sp S = 1 sp R = 0$],
    [$E = 1 sp S = 0 sp R = 1$],
    [$E = 0$],
)

// ==== 驱动表

// #table(
//   columns: 5,
//   align: horizon + center,
//   table.header([$Q^(n+1)$], [$Q^(n)$], [$E$], [$S$], [$R$]),
//   [0], [0], [0], [X], [X],
//   [0], [0], [1], [0], [X],
//   [0], [1], [1], [1], [0],
//   [1], [1], [0], [X], [X],
//   [1], [1], [1], [X], [0],
//   [1], [0], [1], [0], [1],
// )

=== 门控 D 锁存器

由门控 SR 锁存器加上输入反相与互补控制构成，有 $S = E D$、$R = E ne(D)$，因此不会出现非法输入。

==== 电路图

#figure(
    image("images/gated-d-latch-nor.svg", width: 85%),
    caption: [门控 D 锁存器（NOR 实现）],
)

==== 状态方程

$E = 1$ 时，输出 $Q^(n + 1)$ 跟随 $D$
$ Q^(n + 1) = D $

==== 状态转换图

#state-graph(
    [$E = 0$],
    [$E = 1 sp D = 1$],
    [$E = 1 sp D = 0$],
    [$E = 0$],
)

// ==== 驱动表

// #table(
//   columns: 4,
//   align: horizon + center,
//   table.header([$Q^(n+1)$], [$Q^(n)$], [$E$], [$D$]),
//   [0], [0], [0], [X],
//   [0], [0], [1], [0],
//   [0], [1], [1], [1],
//   [1], [0], [1], [0],
//   [1], [1], [1], [1],
//   [1], [1], [0], [X],
// )

== 触发器

虽然加入使能端可以排除非法输入，但 $E N = 1$ 时若输入多次变化（且均合法），则输出也随之翻转。这称为“空翻”，是锁存器的通病。

为此，引入触发器。它仅在时钟脉冲改变时（统一为上升沿，或统一为下降沿）更新状态。

=== SR 触发器

==== 电路图

#figure(
    image("images/SR触发器.png")
)
#figure(
    image("images/窄脉冲产生器.png")
)

==== 状态方程

$ cases(Q^(n + 1) = S + ne(R) Q^n, S R = 0) $

==== 状态转换图

#state-graph([$S=0,R=X$], [$S=1,R=0$], [$S=0,R=1$], [$S=X,R=0$])

// ==== 驱动表

// #table(
//   columns: 4,
//   align: horizon + center,
//   table.header([$Q^(n+1)$], [$Q^(n)$], [$S$], [$R$]),
//   [0], [0], [0], [X],
//   [0], [1], [1], [0],
//   [1], [0], [0], [1],
//   [1], [1], [X], [0],
// )

=== D 触发器

在 D 锁存器基础上加入 CLK。

==== 状态方程

$ Q^(n + 1) = D $

==== 状态转换图

#state-graph(
    [$D = 0$],
    [$D = 1$],
    [$D = 0$],
    [$D = 1$],
)

// ==== 驱动表

// #table(
//   columns: 3,
//   align: horizon + center,
//   table.header([$Q^(n+1)$], [$Q^(n)$], [$D$]),
//   [0], [0], [0],
//   [0], [1], [1],
//   [1], [0], [0],
//   [1], [1], [1],
// )

=== JK 触发器

JK 触发器可看作消除了 SR 禁止状态的改进型 SR 触发器。反馈使 $J=K=1$ 时状态翻转；$J$ 负责置位，$K$ 负责复位。

==== 电路图

#figure(
    image("images/jk-flip-flop-nand.svg", width: 40%),
    caption: [NAND 门构成的 JK 触发器],
)

==== 状态方程

$ Q^(n + 1) = J ne(Q) + ne(K) Q^n $

==== 状态转换图

#state-graph([$J = K = 0$], [$J = 1, K = X$], [$J = X, K = 1$], [$J = K = 0$])

// ==== 驱动表

// #table(
//   columns: 4,
//   align: horizon + center,
//   table.header([$Q^(n+1)$], [$Q^(n)$], [$J$], [$K$]),
//   [0], [0], [0], [X],
//   [0], [1], [1], [X],
//   [1], [0], [X], [1],
//   [1], [1], [X], [0],
// )

=== T 触发器

$T=0$ 保持，$T=1$ 翻转。

==== 状态方程

$ Q^(n + 1) = T ne(Q^n) + ne(T)Q^n $

==== 状态转换图

#state-graph($T = 0$, $T = 1$, $T = 1$, $T = 0$)

// ==== 驱动表

// #table(
//   columns: 3,
//   align: horizon + center,
//   table.header([$Q^(n+1)$], [$Q^(n)$], [$T$]),
//   [0], [0], [0],
//   [0], [1], [1],
//   [1], [0], [1],
//   [1], [1], [0],
// )

== 分析

记 ${Q_k}$ 为电路的现态，${X_m}$ 为输入，${Z_n}$ 为输出。

- #[
    米里型 Mealy：输出和输入&现态相关 $Z_i = f(Q_1, dots.c Q_k, X_1, dots.c, X_m)$
]
- #[
    摩尔型 Moore：输出仅和现态相关 $Z_i = f(Q_1, dots.c, Q_k)$
]