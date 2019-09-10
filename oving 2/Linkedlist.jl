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
    if (index == 1)
        return linkedlist.value
    end
    i = 1
    while typeof(linkedlist.next) != Nothing
        linkedlist = linkedlist.next
        i = i+1
        if (i == index)
            return linkedlist.value
        end
    end
    return -1
end


linkedList = createlinkedlist(5)
println(linkedList)
println(findindexinlist(linkedList, 2))
println(findindexinlist(linkedList, 6))
println(findindexinlist(linkedList, 5))
println(findindexinlist(linkedList, 8))
