mutable struct Node
    i::Int
    j::Int
    floor::Bool
    neighbors::Array{Node}
    color::Union{String,Nothing}
    distance::Union{Int,Nothing}
    predecessor::Union{Node,Nothing}
end
Node(i, j, floor=true) = Node(i, j, floor, [], nothing, nothing, nothing)


### Du skal implementere denne funksjonen ###
function mazetonodelist(maze)
    # Vi lager en matrise nodearray med størrelse tilsvarende maze,
    # men med Node-objekter isteden
    nodearray = Array{Node}(undef, size(maze, 1), size(maze, 2))

    for i in 1:size(maze, 1)
        for j in 1:size(maze, 2)
            if maze[i, j] == 0
                nodearray[i, j] = Node(i, j, false)
            else
                nodearray[i, j] = Node(i, j, true)
            end
        end
    end

    for j in 1:size(maze, 2)
        if nodearray[1, j].floor && nodearray[2, j].floor
            push!(nodearray[1, j].neighbors, nodearray[2, j])
        end
        if nodearray[size(maze, 1), j].floor && nodearray[size(maze, 1)-1, j].floor
            push!(nodearray[size(maze, 1), j].neighbors, nodearray[size(maze, 1)-1, j])
        end
    end
    for i in 1:size(maze, 1)
        if nodearray[i, 1].floor && nodearray[i, 2].floor
            push!(nodearray[i, 1].neighbors, nodearray[i, 1])
        end
        if nodearray[i, size(maze, 2)].floor && nodearray[i, size(maze, 2)-1].floor
            push!(nodearray[i, size(maze, 2)].neighbors, nodearray[i, size(maze, 2)-1])
        end
    end


    for i in 2:size(maze, 1)-1
        for j in 2:size(maze, 2)-1
            # Fyll inn kode for å oppdatere neighbors til hver node
            if (nodearray[i, j].floor)
                if (nodearray[i+1, j].floor)
                    push!(nodearray[i, j].neighbors, nodearray[i+1, j])
                end
                if (nodearray[i-1, j].floor)
                    push!(nodearray[i, j].neighbors, nodearray[i-1, j])
                end
                if (nodearray[i, j+1].floor)
                    push!(nodearray[i, j].neighbors, nodearray[i, j+1])
                end
                if (nodearray[i, j-1].floor)
                    push!(nodearray[i, j].neighbors, nodearray[i, j-1])
                end
            end
        end
    end

    ans::Array{Node, 1} = []
    for i in 1:size(maze, 1)
        for j in 1:size(maze, 2)
            if (nodearray[i,j].floor)
                push!(ans, nodearray[i, j])
            end
        end
    end
    return ans
    # Fyll inn kode for å returnere en nodeliste ut ifra nodearray
end


### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

# (Følgende er hjelpefunksjoner for testene og kan i utgangspunktet ignoreres)
function sortnodelist(nodelist)
    sort!(sort!(nodelist, by=node->node.i), by=node->node.j)
end

function getcoords(nodelist)
    return [(node.i, node.j) for node in nodelist]
end

function getneighborcoords(nodelist)
    return [sort(sort(
               [(neighbor.i, neighbor.j) for neighbor in node.neighbors],
            by = x -> x[1]), by = x -> x[2])
            for node in nodelist]
end

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "LitenLabyrint" begin
    maze = [0 0 0 0 0
            0 1 1 1 0
            0 1 0 0 0
            0 1 1 1 0
            0 0 0 0 0]
    nodelist = mazetonodelist(maze)

    # Test at nodelist er en liste/array med Node-instanser
    # Merk at følgende tester vil feile dersom dette ikke er tilfelet
    @test nodelist isa Array{Node,1}

    # Test at grafen inneholder riktig antall noder
    @test length(nodelist) == 7

    # Vi sorterer nodelist ut ifra koordinatene, ettersom vi ikke pålegger
    # en spesifikk rekkefølge på nodene i nodelist
    sortnodelist(nodelist)

    # Test at koordinatene til hver node er korrekte
    @test getcoords(nodelist) ==
        [(2, 2), (3, 2), (4, 2), (2, 3), (4, 3), (2, 4), (4, 4)]

    # Test at koordinatene til hver nabonode er korrekte
    @test getneighborcoords(nodelist) ==
        [[(3, 2), (2, 3)], [(2, 2), (4, 2)],
         [(3, 2), (4, 3)], [(2, 2), (2, 4)],
         [(4, 2), (4, 4)], [(2, 3)], [(4, 3)]]
end

@testset "MiddelsLabyrint" begin
    maze = [0 0 0 0 0 0 0
            0 1 1 1 1 1 0
            0 1 0 0 0 1 0
            0 1 0 1 0 1 0
            0 1 0 1 0 1 0
            0 1 1 1 0 1 0
            0 0 0 0 0 0 0]
    nodelist = mazetonodelist(maze)

    @test nodelist isa Array{Node,1}

    @test length(nodelist) == 17

    sortnodelist(nodelist)

    @test getcoords(nodelist) ==
        [(2, 2), (3, 2), (4, 2), (5, 2), (6, 2),
         (2, 3), (6, 3), (2, 4), (4, 4), (5, 4),
         (6, 4), (2, 5), (2, 6), (3, 6), (4, 6),
         (5, 6), (6, 6)]

    @test getneighborcoords(nodelist) ==
        [[(3, 2), (2, 3)], [(2, 2), (4, 2)], [(3, 2), (5, 2)],
         [(4, 2), (6, 2)], [(5, 2), (6, 3)], [(2, 2), (2, 4)],
         [(6, 2), (6, 4)], [(2, 3), (2, 5)], [(5, 4)],
         [(4, 4), (6, 4)], [(6, 3), (5, 4)], [(2, 4), (2, 6)],
         [(2, 5), (3, 6)], [(2, 6), (4, 6)], [(3, 6), (5, 6)],
         [(4, 6), (6, 6)], [(5, 6)]]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
