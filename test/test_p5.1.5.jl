using Compat, Base.Test, CSoM

include(Pkg.dir("CSoM", "examples", "ElasticSolids", "FE5_1.jl"))

data = @compat Dict(
  # Plane(ndim, nst, nxe, nye, nip, direction, finite_element(nod, nodof), axisymmetric)
  :element_type => Plane(2, 3, 3, 2, 9, :z, Quadrilateral(4, 2), true),
  :properties => [
     100.0 0.3;
    1000.0 0.45
    ],
  :etype => [1, 2, 1, 2, 1, 2],
  :x_coords => [0.0, 4.0, 10.0, 30.0],
  :y_coords => [0.0, -4.0, -10.0],
  :support => [
    (1, [0 1]),
    (2, [0 1]),
    (3, [0 0]),
    (6, [0 0]),
    (9, [0 0]),
    (10, [0 1]),
    (11, [0 1]),
    (12, [0 0])
    ],
  :loaded_nodes => [
    (1, [0.0  -2.6667]),
    (4, [0.0 -23.3333]),
    (7, [0.0 -24.0])
    ]
)


@time m = FE5_1(data)

@test_approx_eq_eps m.loads [0.0,-0.03176060466236135,-0.003231272451306888,0.0013949965318819561,-0.039904996293397346,0.0011648123636934574,-0.0024979956898815428,0.0017035565573309804,-0.006045921706318328,0.0013301584221295814,-0.000442142378941997,0.0025875517277645756,0.00030906084483465454] eps()