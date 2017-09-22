#ifndef MAIN_H
#define MAIN_H

#include <stdio.h>
#include <stdlib.h>

int displayMenuInterface(StudentDb * db);
void executeMenuAction(StudentDb *db, int action);
void displayAddStudentInterface(StudentDb * db);
void printStudents(StudentDb * db);
void displaySearchByIdInterface(StudentDb * db);
void printStudent(Student student);
void writeStudentDbToFile(FILE * file, StudentDb db);
StudentDb loadStudentDb(FILE * file);
#endif
