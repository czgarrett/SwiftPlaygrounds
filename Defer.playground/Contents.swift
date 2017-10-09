//: Playground - noun: a place where people can play


class Cow {
    
    var chewingCud = false
    
    func moo() {
        defer {
            print("moo!")
        }
        guard !self.chewingCud else {
            print("swallow")
            return
        }
    }
}

let cow = Cow()

cow.chewingCud = true
cow.moo()
