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
#let hookto = math.arrow.r.hook
#let barto = math.arrow.r.bar
#let get = math.arrow.l

#let leq = math.lt.slant
#let geq = math.gt.slant

#let parallel = math.slash.double

#let proof-template(body, prefix: [proof. ]) = block( // using grid to create auto left hanging
    grid(
        columns: (auto, 1fr),
        gutter: 0.5em,
        prefix,
        body,
    ),
)