NF==2 {
    print "s/< *"$1"/<"$2"/gI"
    print "s-< */ *"$1"-</"$2"-gI"
}
