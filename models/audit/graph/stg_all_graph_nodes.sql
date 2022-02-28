-- one row for each node in the graph
with 

enabled_nodes as (
    select 
        unique_id as node_id,
        node_name,
        is_described,
        resource_type,
        file_path
    from {{ ref('base__nodes')}}
    where is_enabled
    -- and package_name != 'pro-serv-dag-auditing'
),

exposures as (
    select 
        unique_id as node_id,
        node_name,
        is_described,
        resource_type,
        file_path
    from {{ ref('base__exposures')}}
),

metrics as (
    select 
        unique_id as node_id,
        node_name,
        is_described,
        resource_type,
        file_path
    from {{ ref('base__metrics')}}
),

sources as (
    select 
        unique_id as node_id,
        node_name,
        is_described,
        resource_type,
        file_path
    from {{ ref('base__sources')}}
),

all_dag_nodes as (
    select * from enabled_nodes

    union all

    select * from exposures

    union all

    select * from metrics

    union all

    select * from sources

)

select * from all_dag_nodes