mutable struct Node
    next::Union{Node, Nothing} # next kan peke på et Node-objekt eller ha verdien nothing.
    value::Int
end



function createlinkedlist(length)
    # Creates the list starting from the last element
    # This is done so the last element we generate is the head
    child = nothing
    node = nothing

    for i in 1:length
        node = Node(child, rand(1:800))
        child = node
    end
    return node
end

function findindexinlist(linkedlist, index)
    for i = 1:(index-1)
        if(typeof(linkedlist.next) == Nothing)
            return -1
        end
        linkedlist = linkedlist.next
    end
    if typeof(linkedlist) == Nothing
        return -1
    end
    return linkedlist.value
end


linkedList = createlinkedlist(5)
println(linkedList)
println(findindexinlist(linkedList, 2))
println(findindexinlist(linkedList, 8))
