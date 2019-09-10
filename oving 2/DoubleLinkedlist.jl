mutable struct NodeDoublyLinked
    prev::Union{NodeDoublyLinked, Nothing} # Er enten forrige node eller nothing
    next::Union{NodeDoublyLinked, Nothing} # Er enten neste node eller nothing
    value::Int # Verdien til noden
end

function maxofdoublelinkedlist(linkedlist)
    max = linkedlist.value

    while typeof(linkedlist.prev) != Nothing # går først baklengs
        linkedlist = linkedlist.prev
        if linkedlist.value > max
            max = linkedlist.value
        end
    end

    while typeof(linkedlist.next) != Nothing # nå går vi fremmover og gjennom hele listen
        linkedlist = linkedlist.next
        if linkedlist.value > max
            max = linkedlist.value
        end
    end
    return max
end
