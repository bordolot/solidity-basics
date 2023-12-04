// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalHistory {
    struct Patient {
        string name;
        uint age;
        string[] conditions;
        string[] allergies;
        string[] medications;
        string[] procedures;
    }

    mapping(address => Patient) public patients;

    function addPatient(
        address _patientAddr,
        string memory _name,
        uint _age,
        string[] memory _conditions,
        string[] memory _allergies,
        string[] memory _medications,
        string[] memory _procedures
    ) public {
        Patient memory patient = Patient(
            _name,
            _age,
            _conditions,
            _allergies,
            _medications,
            _procedures
        );
        patients[_patientAddr] = patient;
    }

    function updatePatient(
        address _patientAddr,
        string[] memory _conditions,
        string[] memory _allergies,
        string[] memory _medications,
        string[] memory _procedures
    ) public {
        Patient storage patient = patients[_patientAddr];
        patient.conditions = _conditions;
        patient.allergies = _allergies;
        patient.medications = _medications;
        patient.procedures = _procedures;
    }

    function getPatient(
        address _patientAddress
    )
        public
        view
        returns (
            string memory,
            uint,
            string[] memory,
            string[] memory,
            string[] memory,
            string[] memory
        )
    {
        Patient memory patient = patients[_patientAddress];
        return (
            patient.name,
            patient.age,
            patient.conditions,
            patient.allergies,
            patient.medications,
            patient.procedures
        );
    }
}
