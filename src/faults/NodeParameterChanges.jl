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
    nodes::Array{Tuple{String,Symbol,Float64}}
    values::Array{Float64}
    tspan_faults::Array{Tuple}
    vars::Array{Symbol}
end

function (gp::NodeParameterChanges)(powergrid)
    for (node, var, value) in gp
        typestable_node_field_update(powergrid, node, var, value)
end

"""
Error to be thrown if something goes wrong during node parameter perturbation.
"""
struct NodePerturbationError <: PowerDynamicsError
    msg::String
end

export NodeParameterChanges
export NodePerturbationError
