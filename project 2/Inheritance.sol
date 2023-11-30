// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* graf of inheritance

       A
      / \ 
     /   \
    B     C
   / \   / 
  F   D,E
*/

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

contract D is B, C {
    // D.foo() returns "C"
    // since C is the right most patent contract with function foo()
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    // E.foo() returns "B"
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}

// Shadowing

contract X {
    string public name = "Contract X";

    function getName() public view returns (string memory) {
        return name;
    }
}

contract Z is X {
    constructor() {
        name = "Contract Z";
    }
}

// Super keyword
/* inheritance graph

      G
    / \  \
   /   \  \
  H     I  J
   \   /  /
    \ /  /
       K
*/

contract G {
    event Log(string _message);

    function foo() public virtual {
        emit Log("G.foo caled");
    }

    function bar() public virtual {
        emit Log("G.bar is called");
    }
}

contract H is G {
    function foo() public virtual override {
        emit Log("H.foo called");
        G.foo();
    }

    function bar() public virtual override {
        emit Log("H.bar is called");
        super.bar();
    }
}

contract I is G {
    function foo() public virtual override {
        emit Log("I.foo is called");
        G.foo();
    }

    function bar() public virtual override {
        emit Log("I.bar is called");
        super.bar();
    }
}

contract J is G {
    function foo() public virtual override {
        emit Log("J.foo is called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("J.bar is called");
        super.bar();
    }
}

contract K is H, I, J {
    function foo() public virtual override(H, I, J) {
        super.foo();
    }

    function bar() public virtual override(H, I, J) {
        super.bar();
    }
}

/*
Funny thing:
When we call bar() from K we receive:
    "J.bar is called"
    "I.bar is called"
    "H.bar is called"
    "G.bar is called"

When we call foo() from K we receive:
    "J.foo is called"
    "I.foo is called"
    "G.foo is called"

THis is because the function foo() from the contract J contains >>super.foo();
    and the function foo() from the contract I contains >>G.foo();
    which is a direct call to the parent contract G
    and in some way stops the execution of the function foo() from the contract H.
    
In a line >> function bar() public virtual override(H, I, J)
we can see order of calling
1. -> J
2. -> I
3. -> H
Any parent higher in the hierarchy, that doesn't use the super keyword stops the execution of functions
from contracts that are lower in the hierarchy.


*/
