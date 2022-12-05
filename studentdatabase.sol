// SPDX-License-Identifier: MIT
pragma solidity >0.8.3;

contract studentData{
    event Log(string func, address sender, uint value, bytes data);

    fallback() external payable{
        emit Log("falback",msg.sender, msg.value,msg.data);
    }

    receive() external payable{
        emit Log("receive",msg.sender, msg.value, "");

    }


    struct student{
        uint id;
        string name;
    }

    student[] students;

    function addStudent(uint id, string memory name) external{
        students.push(student(id,name));
    }


    function getArray() external view returns(student[] memory){
        return students;
    }
    

}