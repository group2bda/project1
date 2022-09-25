# CSCI3907
# Project 1
# Group 2: Matteo Sanchez-Dahl, Latifa Al Jlayel

## set up
install.packages("igraph")
library(igraph)

install.packages("sna")
library(sna)

## set working directory 
setwd('/Users/matteosanchez-dahl/Desktop/F2022/CSCI 3907/projects/project1/group2-project1')

## import data
nodes <- as.matrix(read.table('data_subelj_jdk/ent_subelj_jdk_jdk_class_name.txt'))

# 1k edges 
# edges <- as.matrix(read.table('data_subelj_jdk/out_subelj_jdk_jdk.txt', sep = "", header = F, skip = 2, nrows = 1000))
edges <- as.matrix(read.table('data_subelj_jdk/out_subelj_jdk_jdk.txt', sep = "", header = F, skip = 2))
edges

## convert the edgelist to an igraph object
# graph_from_edgelist(el, directed = TRUE)
net <- graph_from_edgelist(edges, directed = TRUE)
net

V(net)$name <- nodes

## graph
# v1
plot(net, vertex.label = nodes)

##
is.simple.(net)

net_simple = simplify(net,
                      remove.multiple = TRUE,
                      remove.loops = TRUE,
                      edge.attr.comb = "concat"
                      )

plot(net_simple, vertex.label = nodes)

histogram <- hist(igraph::degree(net))

histogram_simple <-hist(igraph::degree(net_simple))

mynet <- V(net_simple)
mynet11 <- V(net_simple)[igraph::degree(net_simple)<5000]
mynet11


##

# plot graph 
plot.igraph(net)

# get the vertices of a graph
V(net)

# get the edges of a graph
E(net)

# get the adjacency matrix
net.adj <- as_adjacency_matrix(net)
net.adj

## graph analytics functions

# Density
# gden 
# gden(dat, g=NULL, diag=FALSE, mode="digraph", ignore.eval=FALSE)
net.density = gden(edges, mode = "digraph")
net.density

# edge density 
igraph::edge_density(net)

igraph::edge_density(net, loops = T)
# there are no loops in the graph => same edge density

### TODO ###
# egocentric network
net.ego <- sna::ego.extract(edges)
# Error: vector memory exhausted (limit reached?)

### TODO ###
net.ego[1]
net.ego[50]
###########

# degree
igraph::degree(net)

## centrality metrics

# betweeness centrality
centr_betw(net)

# closeness centrality
centr_clo(net)
# is NaN an acceptable value result?

## shortest path

# length of the shortest path between any two nodes in a graph g
net.sp <- shortest.paths(net)
net.sp

# get the actual paths (and not just their length) 
get.shortest.paths(net,1)

## geodist
net.gd <- geodist(edges)
net.gd


## number of paths between two nodes
# can multiply the adjacency matrix by itself. The cell numbers specify the number of paths
net.np <- net.adj*net.adj
net.np

## histogram of the degree of the nodes
hist(degree(net))

# edge density 
igraph::edge_density(net)

igraph::edge_density(net, loops = T)
# there are no loops in the graph => same edge density

# diameter
net.d <- igraph::diameter(net)
net.d

# max cliques for node 13 
node13 <- c(13)
net.13clique <- igraph::max_cliques(net, min = NULL, subset = node13)
# At core/cliques/maximal_cliques_template.h:269 : Edge directions are ignored for maximal clique calculation.
net.13clique

# largest cliques
net.lgcliques <- igraph::clique_num(net)
# At core/cliques/maximal_cliques_template.h:269 : Edge directions are ignored for maximal clique calculation.
net.lgcliques

# Exercise: Try to identify the cliques in the plot. Write them down.

# name vertices
V(net)$name

## "astrocollab"
# plot v1
plot(net)

# degree
igraph::degree(net)

# communities
wc <- walktrap.community(net)

plot(wc, net, vertex.size = 15, layout = layout.fruchterman.reingold)

# simplify the graph by removing empty entries from the matrix 
E(net)$weight <- rnorm(ecount(net))
V(net)$weight <- rnorm(vcount(net))
net[1:5, 1:9]

sg <- induced.subgraph(net, which(V(net)$weight > 2.2))
# plot(delete.vertices(sg, igraph::degree(sg)==0), edge.label = round(E(sg)$weight,3))
# Error in delete.vertices(sg, igraph::degree(sg) == 1) : 
# delete.vertices requires an argument of class network.
plot(delete_vertices(sg, igraph::degree(sg)==0), edge.label = round(E(sg)$weight,3))

histogram <- hist(igraph::degree(net))

myGV <- igraph::V(net)
myGV

# analyze vertices for simplification

# degree 0
myGV0 <- igraph::V(net)[igraph::degree(net)==0]
myGV0
# none have degree 0

# degree 1
myGV1 <- igraph::V(net)[igraph::degree(net)==1]
myGV2
# 33 have degree 1

# degree 2
myGV2 <- igraph::V(net)[igraph::degree(net)==2]
myGV2
# 32 have degree 2

# degree 10
myGV10 <- igraph::V(net)[igraph::degree(net)==10]
myGV10  
# 212 have degree 10

# less than degree 10
myGVl10 <- igraph::V(net)[igraph::degree(net)<10]
myGVl10
# 2388 have degree less than 10

# simplify
# v2 - delete all nodes with degree <10
net_v2 <- igraph::delete_vertices(net, myGVl10)
net_v2
plot(net_v2)

# "fb" section

is.simple(net_v2)
edge_attr(net_v2)

# v3 - use simplify to sum the edge weights 
net_v3 = simplify(net_v2,
                  remove.multiple = TRUE,
                  edge.attr.comb = "sum"
)

plot(net_v3)
# Warning message:
# In v(graph) :
# Non-positive edge weight found, ignoring all weights during graph layout.
# still not readable

vertex_attr(net)

# check hist of v3
hist_v3 <- hist(igraph::degree(net_v3))

# remove nodes w degree >500 from v3
myGVg500 <- igraph::V(net_v3)[igraph::degree(net_v3)>500]
net_preview <- igraph::delete_vertices(net_v3, myGVg500)

# check hist
hist_v3preview <- hist(igraph::degree(net_preview))
# most values under 50

# remove nodes w degree <50 from v3
myGVl50 <- igraph::V(net_v3)[igraph::degree(net_v3)<50]
net_v4 <- igraph::delete_vertices(net_v3, myGVl50)

hist_v4 <- hist(igraph::degree(net_v4))

net_v4

plot(net_v4)
# still not readable 

# remove nodes w degree <100 from v3 
myGVl100 <- igraph::V(net_v3)[igraph::degree(net_v3)<100]
net_v5 <- igraph::delete_vertices(net_v3, myGVl100)

hist_v5 <- hist(igraph::degree(net_v5))

net_v5

plot(net_v5)

## communities 
sg <- induced.subgraph(astrocollab, which((astrocollab)$weight > 2.2))
wc_v5 <- walktrap.community(net_v5)

