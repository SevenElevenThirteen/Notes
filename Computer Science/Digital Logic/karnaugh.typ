/* by DeepSeek V4.1 Flash */

// #set page(width: auto, height: auto, margin: 1.5cm)
// #set text(font: "New Computer Modern", size: 13pt)

#let rev(a) = a.fold((), (acc, x) => (x,) + acc)

// 生成 k 位格雷码序列，返回位数组的数组（如 k=2 -> (0,0),(0,1),(1,1),(1,0)）
#let gray(k) = {
  if k == 0 { return ((),) }
  let prev = gray(k - 1)
  prev.map(b => (0,) + b) + rev(prev).map(b => (1,) + b)
}

// 由变量取值位（高位在前）计算最小项编号
#let mnum(bits) = {
  let n = bits.len()
  bits.enumerate().fold(0, (acc, e) => acc + e.at(1) * calc.pow(2, n - 1 - e.at(0)))
}

// 绘制卡诺图：vars 为变量名数组（如 ("A", "B")）
#let kmap(vars) = {
  let n = vars.len()
  let nr = calc.floor(n / 2)      // 行变量个数
  let nc = n - nr                 // 列变量个数
  let rowvars = vars.slice(0, nr)
  let colvars = vars.slice(nr)
  let rows = gray(nr)
  let cols = gray(nc)

  let cw = 1.15cm                 // 单元格宽
  let ch = 0.9cm                  // 单元格高
  let hw = cw * 1.4               // 表头单元格宽

  // 左上角：左下为行变量，右上为列变量
  let corner = box(width: hw, height: ch)[
    #place(line(start: (0pt, 0pt), end: (hw, ch), stroke: 0.6pt + luma(120)))
    #place(bottom + left, text(weight: "bold", size: 13pt, rowvars.join("")))
    #place(top + right, text(weight: "bold", size: 13pt, colvars.join("")))
  ]

  grid(
    columns: (hw,) + (cw,) * cols.len(),
    rows: (ch,) * (rows.len() + 1),
    stroke: 0.6pt + luma(120),
    inset: 3pt,
    align: center + horizon,
    fill: (x, y) => if x == 0 or y == 0 { luma(235) } else { none },
    corner,
    ..cols.map(c => text(weight: "bold", c.map(str).join(""))),
    ..rows.map(r => (
      text(weight: "bold", r.map(str).join("")),
      ..cols.map(c => text(str(mnum(r + c)))),
    )).flatten(),
  )
}

// #align(center)[
//   #text(size: 16pt, weight: "bold")[2 变量卡诺图]
//   #v(0.3cm)
//   #kmap(("A", "B"))
// ]

// #v(1cm)

// #align(center)[
//   #text(size: 16pt, weight: "bold")[3 变量卡诺图]
//   #v(0.3cm)
//   #kmap(("A", "B", "C"))
// ]

// #v(1cm)

// #align(center)[
//   #text(size: 16pt, weight: "bold")[4 变量卡诺图]
//   #v(0.3cm)
//   #kmap(("A", "B", "C", "D"))
// ]
