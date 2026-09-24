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

/* spacing */
// em is the size of cur font, about the width of one Chinese character
#let en = sym.space.en // 1/2 em, about one letter in monospaced font e.g. console
#let sp = sym.space
// space: 1/4 em, equal to a normal "space" when enter a "space"

// wide : 2    em, ~ \qquad 
// quad : 1    em, ~ \quad
// thick: 5/18 em, ~ \;
// med  : 2/9  em, ~ \:
// thin : 1/6  em, ~ \,

/* general math abbr. */
#let iff = math.arrow.l.r.double
#let imply = math.arrow.r.double
#let to = math.arrow.r
#let get = math.arrow.l

#let leq = math.lt.slant
#let geq = math.gt.slant
#let neq = math.eq.not // or use !=

#let proof-style = [proof.]
#let proof(body) = block( // using grid to create auto left hanging
    grid(
        columns: (auto, 1fr),
        gutter: 0.5em,
        proof-style,
        body,
    ),
)

/* specific math abbr. */
#let LM = $cal(L)$ // linear map
#let dirsum = math.plus.o // direct sum

#let range = "range"
#let null = "null"

// norm(u) => ||u||
#let orcom(u) = $#u^bot$ // orthogonal complement
#let dotpro(u, v) = $chevron #u, #v chevron.r$

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

        #text(size: 80pt)[
            #set par(spacing: 40pt)
            
            Linear Algebra

            Done Right
        ]

        #v(1em)
        #text(size: 40pt)[
            1001
        ]

        #v(6em)
        #text(size: 20pt)[
            #datetime.today().display()
        ]
    ]
]
#counter(page).update(1)

#let prefixs = ("Chapter", "Section", "")
#set heading(numbering: (..arr) => { // type(arr) is argument; Or can also use numbly to replace all these stuffs !
    arr = arr.pos() // .pos() captures positional arguments

    if arr.len() == 1 {
        return [
            #set text(size: 三号)
            #prefixs.at(0)
            #numbering("1", arr.at(0))
        ]
    }
    if arr.len() == 2 {
        return [
            #set text(size: 三号)
            #numbering("1A", arr.at(0), arr.at(1))
        ]
    }
    if arr.len() == 3 {
        return [ // at most 3, since outline.depth = 3
            #set text(size: 三号)
            #numbering("1", arr.at(2))
        ]
    }
    return []
})

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
        page()[
            #set align(center + horizon)
            #set text(size: 初号)

            #text()[ #prefixs.at(0) #numbering("1", arr.at(0)) ]
            #v(1em)
            #it.body
        ]
    }
    else if it.level == 2 {
        align(center)[
            #set text(size: 一号)
            #set par(spacing: 15pt)

            #text()[
                #numbering("1A", arr.at(0), arr.at(1))
                #(" ")
                #it.body
            ]

            #divider()
        ]
    }
    else if it.level == 3 [
        #set text(size: 小二)
        #text()[
            #numbering("1.", arr.at(2))
        ]
        #it.body
    ]
    else [
        #set text(size: 小三)
        #it.body
    ]
}

#counter(heading).update(5)
= Inner Product Spaces

#counter(heading).update((6, 2))
== Orthogonal Complements

=== Orthogonal Complement

*Def*. *Orthogonal Complement*

$U subset V$, *not necessary to be a subspace*, then the orthogonal complement of $U$ is the set of all vectors that are orthogonal to every vector in $U$
$ orcom(U) := {v in V: forall u in U, dotpro(u, v) = 0} $

e.g. 取 $V$ 为所有二维向量的集合，$U = {(1, 1)}$，则 $orcom(U)$ 为 $y = -x$ 上的所有向量。

*Prop*

#[
    #set enum(numbering: "a.")
    + #[
        $orcom(U)$ is a subspace of $V$.

        验证定义。
    ]

    + #[
        $orcom({0}) = V, en orcom(V) = {0}$

        前者显然，后者 $u != 0 imply dotpro(u, u) != 0 imply u in.not orcom(V)$
    ]
    + #[
        $U inter orcom(U) subset {0}$

        显然。不取等因为可以 $0 in.not U$
    ]
    + #[
        If subset $G subset H subset V$, then $orcom(H) subset orcom(G)$

        显然。
    ]
]

*Prop*. A natural decomposition \
If $U subset V$ is *finite*-dimensional subspace, then
$ V = U dirsum orcom(U) $

#proof()[
    *rewrite using the orthogonal basis of $U$*

    Let ${e_m}$ be a orthogonal basis of $U$, consider
    $ v = underbrace(sum dotpro(v, e_i) e_i, u in U) en + en underbrace(v - sum dotpro(v, e_i) e_i, w) $
    Only need to prove $w in orcom(U)$, and thus only need to prove $dotpro(w, e_i) = 0$ for all $e_i$. Obviously.
]

*Cov*. If $U subset V$ is finite-dimensional subspace, then  $dim orcom(U) = dim V - dim U$

*Prop*: Orthogonal complement of orthogonal complement \
If $U subset V$ is a finite-dimensional subspace, then
$ U = orcom((orcom(U))) $
proof.
- #[
    $U subset orcom((orcom(U)))$: 
    by definition, $u in U imply dotpro(u, v) = 0 space forall v in orcom(U) imply u in orcom((orcom(U)))$
]
- #[
    $orcom((orcom(U))) subset U$: suppose $v in orcom((orcom(U)))$. Since $V = U dirsum orcom(U)$, then $v = u + w$ for some $u in U, w in orcom(U)$. From above $U subset orcom(orcom(U))$, so $u in orcom((orcom(U)))$. Therefore
    $ cases(
        reverse: #true,
        w = v - u &in orcom((orcom(U))),
        w &in orcom(U)
    ) imply w in orcom(U) inter orcom(orcom(U)) = {0} imply w = 0 imply v = u $
    Which leads to $v in U imply orcom((orcom(U))) subset U$.
]

*Cov*. $U = V iff orcom(U) = {0}$

#divider()

*Def*. *Orthogonal Projection* 正交投影

Let $U$ is a finite-dimensional subspace of $V$. The orthogonal projection of $V$ onto $U$ is the operator $P_U in LM(V)$:
$ P_U v = u en "iff" v = u + w, sp u in U, sp w in orcom(U)  $

$P_U$ 把 $v$ 拍到低维空间。

*Prop*: Suppose $U$ is a finite-dimensional subspace of $V$.
#[
    #set enum(numbering: "a.")
    + #[
        $P_U in LM(V)$

        $P_U$ 定义本身不显式说明，逐一验证。
    ]

    + #[
        $forall u in U, med P_U (u) = u quad forall w in orcom(U), med P_U (w) = 0$

        显然。
    ]
    + #[
        $range P_U = U en null P_U = orcom(U)$

        显然。
    ]
    + #[
        $v - P_U (v) in orcom(U)$

        定义。
    ]
    + #[
        $P_U^2 = P_U$

        If $v = u + w$, then $P_U v = u$, $P_U (P_U v) = P_U u = u$ from above.
    ]
    + #[
        $forall v in V, en norm(P_U v) leq norm(v)$

        $norm(v)^2 = dotpro(u + w, u + w) = dotpro(u, u) + dotpro(w, w) + 2 dotpro(u, w) = norm(P_U u)^2 + dotpro(w, w)$
    ]
    + #[
        If ${e_m}$ is an orthogonal basis of $U$, then $forall v in V$,
        $ P_U v = sum dotpro(v, e_i) e_i $
        前文已用过。
    ]
]

=== Minimizatino Problems