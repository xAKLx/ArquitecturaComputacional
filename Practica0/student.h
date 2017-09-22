#ifndef STUDENT_H
#define STUDENT_H

typedef struct student {
  unsigned id;
  char firstName[50];
  char lastName[50];
  unsigned age;
  float gpa;
} Student;

typedef struct studentNode {
  Student student;
  struct studentNode * next;
} StudentNode;

typedef struct studentDb {
  int count;
  int lastIdAssigned;
  StudentNode* first;
  StudentNode* last;
} StudentDb;

/**
  Initialize a StudentDb.
  @param count quantity of student in studentList
  @param studentList list of students, This function will keep a copy of each
    student.
  @param lastIdAssigned last id assigned to a student.
*/
StudentDb initDb(int count, Student * studentList, int lastIdAssigned);

/**
  Adds the student to the given db, assigns the id.
  @param db pointer to the db where the student will be added.
  @param Student student to add to the db.
*/
void addNewStudent(StudentDb * db, Student student);

/**
  Gets a student from the provided db by the provided id.
  @param db a pointer to the db where the student is in.
  @param id the id of the student.
  @return A pointer to the student or NULL if the id is not found.
*/
Student * getStudent(StudentDb * db, unsigned id);

/**
  Release all the memory related to the db.
*/
void destroyDb(StudentDb * db);

#endif
