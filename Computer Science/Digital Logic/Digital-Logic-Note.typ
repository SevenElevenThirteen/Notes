/* packages */
#import "../../__Template/Typst-Template/Packages-for-Typst-Template.typ": *
#show: environment

/* abbrs */
#import "../../__Template/Typst-Template/Abbrs-for-Typst-Template.typ": *
#let proof = proof-template.with(prefix: [证明：]) // more recommended by GPT 5.6 Luna, and get ce when try to use set/show

/* Circuit */
#import "@preview/zap:0.6.0"
#let ieee-circuit(body) = zap.circuit({ // use IEEE style
    import zap: *
    set-style(variant: "ieee")
    body
})
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
    else {
        it
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
        
    ],

    [与或], [$overline(A + B)$], [
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

最小项

相邻最小项：$n-1$ 个变量相同，另一个 $A$ 和 $ne(A)$

*卡诺图*

将 $n$ 变量的 $2^n$ 个最小项排成循环矩阵，使得相邻最小项 $iff$ 相邻方格。为此，将变量均匀分配至行列，按格雷码排列。
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