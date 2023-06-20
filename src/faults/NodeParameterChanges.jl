@doc """
```Julia
NodeParameterChanges(;nodes, values, tspan_faults, vars)
```
# Keyword Arguments
- `nodes`: numbers or names of the nodes
- `values`: values of power during fault events
- `tspan_faults`: PowerPerturbation timespans
- `vars`:  symbol of parameters that are perturbed
"""
Base.@kwdef struct NodeParameterChanges <:AbstractPerturbation
    nodes
    values
    tspan_faults::Tuple
    vars::Symbol
end

function (gp::NodeParameterChanges)(powergrid)
    for gp_i in gp
        typestable_node_field_update(powergrid, gp_i.nodes, gp_i.vars, gp_i.values)
end

"""
Error to be thrown if something goes wrong during node parameter perturbation.
"""
struct NodePerturbationError <: PowerDynamicsError
    msg::String
end

export NodeParameterChanges
export NodePerturbationError
