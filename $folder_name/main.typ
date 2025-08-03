#import "lab-report.typ": lab-report
#import "@preview/lilaq:0.3.0" as lq
#import calc: ln, round
#import "lib.typ": linear_fit

#show: lab-report.with(
  title: "Electron Spin Resonance",
  authors: ("Raul Wagner", "Martin Kronberger"),
  supervisor: "Victor Lindenbauer",
  groupnumber: "301",
  date: datetime(day: 4, month: 6, year: 2025),
)

#outline()

#pagebreak()

= Resonanceabsorbtion of a passive HF-Osscilator

== Fundamentals

To detect electron spin resonance (ESR) in DPPH, the DPPH sample is placed in an RF coil that is part of a resonant circuit with  high quality factor . This circuit is excited by a variable-frequency RF oscillator operating between 15 and 130 MHz.

When the resonance condition for ESR is met at a frequency $nu_0$​, the DPPH sample absorbs energy, which loads the resonant circuit. As a result, the AC resistance increases, and the voltage across the RF coil decreases.

To detect this change, a passive resonant circuit is used for comparison. Its coil is placed coaxially opposite the empty RF coil. The resonance frequency of the passive circuit is given by:
$
  nu_0 = 1/(2 pi dot sqrt(L_2 C_2))
$
Where $L_2$ and $C_2$ are the inductance and capacitance of the oscillation circuit.
The resonance frequency of the circuit can be adjusted by changing the capacitance $C_2$​.

When the active circuit is driven at its resonance frequency $nu_0$, it is dampened, and the voltage $U_1$​ across the RF coil decreases.
The ESR signal is detected by measuring the rectified voltage $U_1$, which corresponds to the current $I_1$​ through a measurement resistor $R_1=56 space "k"Omega$:
$
  U_1​= 56 space "k"Omega dot I_1​
$

#cite(<elektronenspinresonanz-2025>)

== Setup

#figure(
  image(width: 8cm, "assets/experimental_setup_1.png"),
  caption: [Experimental setup with the ESR base unit and an inductively coupled passive resonant circuit. #cite(<elektronenspinresonanz-2025>)],
)

- Connect the ESR base unit to the ESR operating unit via a 6-pin cable and set the rotary potentiometer on the top left to maximum sensitivity.

- Plug in the 13-30 MHz plug-in coil (large).

- Due to a bad connection of the measurement cable of $I_1$ the current and voltage of the active circuit could not be measured.

- Position the coil of the passive resonant circuit coaxially opposite of the active coil and connect via a BNC/4 mm measurement cable to channel I of the dual-channel oscilloscope.

#cite(<elektronenspinresonanz-2025>)

== Procedure

- Set the variable capacitor of the passive resonant circuit to position Skt. = 3/6.

- Adjust the minimum frequency on the ESR base unit.

- At the operating frequency, measure and record:

  - the frequency,

  - the voltage $U_2$ of the “passive” coil on the oscilloscope,

- Increase the frequency in steps and repeat the measurement.

- Perform additional measurement series with Skt. = 2/6 and 1/6.

- A measurement without the passive circuit could also not be done due to the bad connection of the active circuit cable.

#cite(<elektronenspinresonanz-2025>)

== Measurement values

The active coil voltage $U_1(nu)$ could not be recorded, because the current measurement branch of the apparatus was broken during the time of the experiment.
As a result, no data for $U_1$ were obtained, and only the passive coil voltage $U_2(nu)$ is available for analysis.
This won't be hindering the determination of the resonance frequencies of the LC-Oscillator, since it can be read out of the $U_1$ dataset in isolation.

#let data_3_6 = (
  //(freq, U2),
  (11.5, 1.00),
  (12.0, 1.01),
  (12.5, 1.15),
  (13.0, 1.20),
  (13.5, 1.40),
  (14.0, 1.60),
  (14.5, 1.80),
  (15.0, 2.20),
  (15.5, 2.35),
  (16.0, 2.20),
  (16.5, 2.00),
  (17.0, 1.80),
  (17.5, 1.25),
  (18.0, 1.00),
  (18.5, 0.80),
  (19.0, 0.70),
)

#let data_2_6 = (
  //(freq, U2),
  (11.5, 0.80),
  (12.5, 0.85),
  (13.5, 0.90),
  (14.5, 0.97),
  (15.5, 1.05),
  (16.5, 1.20),
  (17.0, 1.30),
  (17.5, 1.40),
  (18.0, 1.50),
  (18.5, 1.60),
  (19.0, 1.70),
  (19.5, 1.60),
  (20.0, 1.50),
  (20.5, 1.35),
  (21.0, 0.95),
  (21.5, 0.80),
)

#let data_1_6 = (
  //(freq, U2),
  (18.0, 0.75),
  (19.0, 0.80),
  (20.0, 0.85),
  (21.0, 0.90),
  (22.0, 0.95),
  (23.0, 1.00),
  (23.5, 1.05),
  (24.0, 1.10),
  (24.5, 1.15),
  (25.0, 1.10),
  (25.5, 1.05),
  (26.0, 1.00),
  (26.5, 0.95),
  (27.0, 0.90),
  (27.5, 0.80),
)

#let draw_table(data, caption) = {
  let mid = int(round(data.len() / 2))
  let table_data = data.slice(0, -mid).zip(data.slice(mid))

  figure(caption: [#caption], table(
    columns: 4,
    align: center,
    stroke: 0.8pt,
    table.header([$nu$ / MHz], [$U_2$ / V], [$nu$ / MHz], [$U_2$ / V]),
    ..for (.., (v, u2), (cont_v, cont_u2)) in table_data {
      ([#v], [#u2], [#cont_v], [#cont_u2])
    },
  ))
}

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.5cm,
  [#draw_table(
      data_3_6,
      [Measured voltage $U_2$ at fixed frequencies $nu$ at scale division 3/6],
    )<tab:U2-3-6>],
  [#draw_table(
      data_2_6,
      [Measured voltage $U_2$ at fixed frequencies $nu$ at scale division 2/6],
    )<tab:U2-2-6>],
)

#draw_table(
  data_1_6,
  [Measured voltage $U_2$ at fixed frequencies $nu$ at scale division 1/6],
)<tab:U2-1-6>
#show lq.selector(lq.legend): set text(1em)
#show lq.selector(lq.title): set text(1.5em)

#let get_freq(data) = {
  data.map(x => x.at(0))
}

#let get_volt(data) = {
  data.map(x => x.at(1))
}

== Data analysis

After the plotting of the Voltage data, peaks are identified for simplicity only using the maximum Voltage value of each dataset.
This might introduce slight errors, since the actual peak could be situated slighty shifted on either side of the measured peak.
To get a more accurate peak information peak finding methods could be used.

#figure(
  caption: [Passive coil voltage $U(nu)$ vs frequency $nu$, with resonance frequencies $nu_(3\/6), nu_(2\/6) "and" nu_(1\/6)$ indicated by vertical lines. (see: @tab:U2-3-6 - @tab:U2-1-6)],

  lq.diagram(
    width: 12cm,
    height: 8cm,
    ylabel: [Passive coil voltage $U_2$ in V],
    xlabel: [Frequency $nu$ in Hz],
    lq.line(
      (
        get_freq(data_3_6).at(get_volt(data_3_6).position(x => (
          x == calc.max(..get_volt(data_3_6))
        ))),
        0.6,
      ),
      (
        get_freq(data_3_6).at(get_volt(data_3_6).position(x => (
          x == calc.max(..get_volt(data_3_6))
        ))),
        2.6,
      ),
    ),
    lq.plot(
      color: blue,
      mark: lq.marks.o,
      label: [Skt. = 3/6],
      get_freq(data_3_6),
      get_volt(data_3_6),
    ),
    lq.place(31%, 10%, $nu_(3\/6)$),
    lq.line(
      (
        get_freq(data_2_6).at(get_volt(data_2_6).position(x => (
          x == calc.max(..get_volt(data_2_6))
        ))),
        0.6,
      ),
      (
        get_freq(data_2_6).at(get_volt(data_2_6).position(x => (
          x == calc.max(..get_volt(data_2_6))
        ))),
        2.6,
      ),
    ),
    lq.plot(
      color: orange,
      mark: lq.marks.o,
      label: [Skt. = 2/6],
      get_freq(data_2_6),
      get_volt(data_2_6),
    ),
    lq.place(51%, 30%, $nu_(2\/6)$),
    lq.line(
      (
        get_freq(data_1_6).at(get_volt(data_1_6).position(x => (
          x == calc.max(..get_volt(data_1_6))
        ))),
        0.6,
      ),
      (
        get_freq(data_1_6).at(get_volt(data_1_6).position(x => (
          x == calc.max(..get_volt(data_1_6))
        ))),
        2.6,
      ),
    ),
    lq.plot(
      color: purple,
      mark: lq.marks.o,
      label: [Skt. = 1/6],
      get_freq(data_1_6),
      get_volt(data_1_6),
    ),
    lq.place(82%, 60%, $nu_(1\/6)$),
  ),
)

The measured $U_2(nu)$ curve exhibits three clear peaks at approximately 16 Hz, 19 Hz, and 25 Hz, which should align with the expected LC resonance modes $nu_(3\/6), nu_(2\/6) "and" nu_(1\/6)$.
Each maximum marks a frequency at which energy oscillates most efficiently between the coil’s inductance and its capacitance.
Between these resonances, the voltage falls off, reflecting the reduced impedance mismatch away from the natural oscillation frequencies.

#pagebreak()

= Electronspinresonance on DPPH

== Fundamentals
Electron spin resonance (ESR) detects transitions between spin states of unpaired electrons in a magnetic field $B_0$​. The energy levels split due to the Zeeman effect, and when electromagnetic radiation of the right frequency $nu$ is applied, resonant absorption occurs.

This resonance condition is:
$
  h nu = g mu_B B_0
$

Where $h$ is the planks constant, $nu$ is the radiation frequency, $g$ is the lande g-factor, $mu_B$ the Bohr magneton and $B_0$ the static magnetic field $B_0$.

From this, the magnetic field $B_0$​ can be calculated using:
$
  B_0 = (h nu) / (g mu_B) quad arrow quad g = nu/B_0 dot h / mu_B
$<eq:gfactor>

The magnetic field $B$ of the Helmholtz coils can be calculated from the current $I$ through each coil using the following formula:
$
  B_0 = mu_0 dot (4 / 5)^(3/2) dot n / r dot I
$
where $mu_0 = 4 pi dot 10^(-7) "Vs"/"Am"$ is the vacuum permability, $n$ the number of turns per coil and $r$ the coil radius.

For $n=320$ and $r=6.8 "cm"$ this yields:
$ B_0 = 4.23 "mT"/"A"⋅I $<eq:magnetic-field>

#cite(<elektronenspinresonanz-2025>)

== Setup
\
#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.5cm,
  align: horizon,
  [
    #figure(
      image(width: 8cm, "assets/experimental_setup_2.png"),
      caption: [Experimental setup for electron spin resonance #cite(<elektronenspinresonanz-2025>)],
    )<fig:experimental-setup>
  ],
  [
    #figure(
      image(width: 3.6cm, "assets/experimental_setup_3.png"),
      caption: [Arrangement of the Helmholtz coils and the ESR base unit, viewed from above. #cite(<elektronenspinresonanz-2025>)<test>],
    )<fig:helmholz-coil>
  ],
)\
- Place the Helmholtz coils parallel to each other at a center distance of 6.8 cm (equal to the mean radius $r$).

- Connect both Helmholtz coils in series with the ammeter to the ESR operating unit.

- Connect the ESR base unit to the ESR operating unit via a 6-pin cable.

- Connect output Y of the ESR operating unit via a BNC cable to channel I of the dual-channel oscilloscope, and output X to channel II.

#cite(<elektronenspinresonanz-2025>)

== Procedure

2,2-diphenyl-1-picrylhydrazyl (DPPH) is used as a stable free radical sample.
The magnetic field is generated by Helmholtz coils and modulated at 50 Hz.
A high-Q RF resonant circuit detects the absorption via a drop in voltage when resonance occurs.

*Determination of the Resonance Magnetic Field $B_0$*

- Insert the 30-75 MHz plug-in coil (medium) and place the DPPH sample in the coil.

- Switch on the ESR base unit and position it so that the plug-in coil with DPPH sample is in the center of the Helmholtz-coil pair (see @fig:helmholz-coil).

- Set the resonance frequency $nu = 30 "MHz"$.

- Set the modulation amplitude $U_"mod"$ to the second scale division.

- Set the phase shift to $0°$.

- Operate the oscilloscope in dual-channel mode:
  - Dual on

  - Time base $2"ms"/"cm"$

  - Amplitude I and II $0.5 "V"/"mm"$ AC
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1cm,
  align: horizon,
  [
    - Slowly increase the DC voltage $U_0$ to the Helmholtz coils until the resonance signals are equidistant.

    - Switch the oscilloscope to XY mode and adjust the phase shift so that the two resonance peaks coincide.

    - Vary $U_0$ until the resonance signal is symmetric, keeping the modulation voltage as low as possible. (see @resonance-signal)
  ],
  [
    #figure(caption: [Symmetric and equidistant resonance signal], image(
      width: 5cm,
      "assets/resonance_curve.jpeg",
    ))<resonance-signal>
  ],
)
- Measure the DC current $2 I_0$ through the Helmholtz-coil pair and record it together with the resonance frequency $nu$.

- Increase $nu$ by $5 "MHz"$ and adjust $U_0$ to reestablish resonance.

- Again measure and record the current $2 I_0$.

- Continue raising $nu$ in 5 MHz steps (switch to the 75-130 MHz coil (small) at 75 MHz) and repeat the measurements.

#cite(<elektronenspinresonanz-2025>)

*Determination of the full width at half maximum (FWHM) $delta B_0$*
- Operate the oscilloscope in XY mode:

  - Amplitude II $0.05 "V"/"mm" "AC"$

- Reestablish the resonance condition for $nu = 50 "MHz"$ (medium plug-in coil).

- Vary the modulation voltage $U_"mod"$ until the resonance trace spans the full screen width (10 cm) in the X-direction.

- Switch the ammeter to AC mode and measure the effective current $2 I_"mod"$ corresponding to $U_"mod"$.

- Increase the X-deflection, read off the width $Delta U$ of the resonance peak at half its height, and record it.

#cite(<elektronenspinresonanz-2025>)

== Measurement values

#let data_2 = (
  (30, 0.53, "middle"),
  (35, 0.63, "middle"),
  (40, 0.71, "middle"),
  (45, 0.79, "middle"),
  (50, 0.89, "middle"),
  (55, 0.97, "middle"),
  (60, 1.06, "middle"),
  (65, 1.15, "middle"),
  (70, 1.23, "middle"),
  (75, 1.33, "middle"),
  (80, 1.41, "middle"),
  (80, 1.53, "small"),
  (90, 1.65, "small"),
  (95, 1.67, "small"),
  (100, 1.70, "small"),
  (105, 1.74, "small"),
  (110, 1.79, "small"),
  (115, 2.05, "small"),
  (120, 2.16, "small"),
  ([], [], []),
)

#let mid = int(data_2.len() / 2)
#let table_data_2 = data_2.slice(0, -mid).zip(data_2.slice(mid))

#let data_2 = data_2.slice(0, -1)

#align(center)[
  #figure(
    caption: [Current $2 I_0$ at given frequency $nu$ of the magnetic field],
    table(
      columns: 6,
      table.header(
        [$nu$ / MHz],
        [$2I_2$ / A],
        [Plug-in coil],
        [$nu$ / MHz],
        [$2I_2$ / A],
        [Plug-in coil],
      ),
      ..for (.., (v, i2, coil), (cont_v, cont_i2, cont_coil)) in table_data_2 {
        ([#v], [#i2], [#coil], [#cont_v], [#cont_i2], [#cont_coil])
      },
    ),
  )
]

Using @eq:magnetic-field the corresponding magnetic field for every current can be calculated, noting that the current values are in $2I_2$ resulting in an additional factor of $1/2$.
This results in the values shown in @tab:magnetic-field:

#let freq_B0 = get_freq(data_2)

#let get_curr(data) = {
  data.map(x => x.at(1))
}

#let B0 = get_curr(data_2).map(I => 4.23 * I / 2)

#let table_data = {
  let B0 = B0.map(x => round(x, digits: 2))
  let table_data = freq_B0.zip(B0)
  table_data.push(([], []))
  mid = int(table_data.len() / 2)
  table_data.slice(0, -mid).zip(table_data.slice(mid))
}

#align(center)[
  #figure(
    caption: [Magnetic field $B_0$ as a function of  frequency $nu$ of the magnetic field],
    table(
      columns: 4,
      stroke: 0.8pt,
      table.header([$nu$ / MHz], [$B_0$ / mT], [$nu$ / MHz], [$B_0$ / mT]),
      ..for (.., (v, b0), (cont_v, cont_b0)) in table_data {
        ([#v], [#b0], [#cont_v], [#cont_b0])
      },
    ),
  )<tab:magnetic-field>
]



#let delta_U = 1.9 * 0.5 // in cm * V/cm
Measured voltage FWHM: $delta U = #delta_U space "V"$

== Data analysis

#let lin_fit = linear_fit(B0, freq_B0)

#let slope = round(lin_fit.at(0), digits: 2)
#let intercept = round(lin_fit.at(1), digits: 2)

#let slope_error = round(lin_fit.at(2), digits: 2)

Using a simple linear-regression model a linear function can be fitted onto the values of the magnetic field, where the slope corresponds to $(Delta nu)/(Delta B_0)$ is in the linear case is equal to $nu/B_0$.
Which will make it possible to use in @eq:gfactor to calculate the g-factor of the probe.

The uncertainty introduced through the linear fit is around $plus.minus #slope_error "Mhz"/"mT"$, uncertainty of $I$ or $B_0$ measurement does not affect the g-factor, since we are purely using the fitted slope of $nu(B_0)$.
Also even tho the intercept is expected to be 0, there might be miss calibrations which result in a y-shift of the curve, resulting in a non-zero intercept.
This y-shift should not have any influence on the value of the slope.

#figure(
  caption: [Resonance frequency as a function of the magnetic field for DPPH (see @tab:magnetic-field)],
  lq.diagram(
    width: 10cm,
    height: 6cm,
    xlabel: [Magnetic field for DPPH $B_0$],
    ylabel: [Resonance frequency $nu_0(B)$],
    ylim: (25, 140),
    lq.plot(color: blue, mark-size: 6pt, stroke: none, B0, freq_B0),
    lq.plot(
      color: blue,
      mark: none,
      stroke: 1.2pt,
      label: [Linear fit: $nu(B_0) approx #round(slope) B_0 - #(-round(intercept))$],
      lq.linspace(B0.first(), B0.last()),
      lq
        .linspace(B0.first(), B0.last())
        .map(x => x * lin_fit.first() + lin_fit.last()),
    ),
  ),
)

#let U_mod = 10 * 0.5 // in cm * V/cm

#let I_mod_2 = 0.29 // in A

#let delta_I = delta_U / U_mod * I_mod_2 / 2 * 2 * calc.sqrt(2)

#let factor = 4

#let delta_B0 = delta_I

*FWHM calculation:*

Using the FWHM of the voltage $U$ we can determine the FHWM of $B_0$ using the following equations:
$
  delta B_0 = 4.23 "mT" dot delta I = 4.23 "mT" dot (delta U) / U_mod dot I_mod
$

thus the FWHM of the magnetic field yields:
#align(center)[
  $delta B_0 approx #round(delta_I * 4.23, digits: 2) "mT"$, compared to common values of $delta B_0 ("DPPH") = 0,15−0,81 "mT"$.
]

*g-factor calculation:*

#let gfactor = (6.625e-34 / 9.273e-24 * lin_fit.first() * 1e9)
#let error = (6.625e-34 / 9.273e-24) * slope_error * 1e9

In experiment determined g-factor using @eq:gfactor combined with the slope of the linear fit:
#align(center)[
  $g = #round(gfactor, digits: 2) plus.minus #round(error, digits: 2)$ compared to the literature value of $g = 2.0036$
]

The linear relation $nu prop B_0$ confirms Zeeman splitting of DPPH electron spins. The extracted $g = #round(gfactor, digits: 2) plus.minus #round(error, digits: 2)$ agrees well with the literature, and the measured field half‐width $delta B_0 approx #round(delta_I * 4.23, digits: 2)"mT"$ reflects intrinsic line broadening due to spin–spin relaxation and field inhomogeneities and lies in the range of expected values.

#pagebreak()

#outline(title: [List of Tables], target: figure.where(kind: table))
#outline(title: [List of Figures], target: figure.where(kind: image))

#bibliography("bib.yaml")
