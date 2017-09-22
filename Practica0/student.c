#include "student.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

void addStudent(StudentDb * db, Student student)
{
  StudentNode * node = (StudentNode *) calloc(1, sizeof(StudentNode));
  node->next = NULL;
  node->student = student;

  if(db->first == NULL)
  {
    db->first = node;
  }
  else
  {
    db->last->next = node;
  }

  db->last = node;
  db->count++;
}

/**
  Initialize a StudentDb.
  @param count quantity of student in studentList
  @param studentList list of students, This function will keep a copy of each
    student.
  @param lastIdAssigned last id assigned to a student.
*/
StudentDb initDb(int count, Student * studentList, int lastIdAssigned)
{
  StudentDb db;
  int i;
  db.lastIdAssigned = lastIdAssigned;

  db.count = 0;
  for(i=0; i < count; i++)
  {
    addStudent(&db, studentList[i]);
  }

  return db;
}

/**
  Adds the student to the given db, assigns the id.
  @param db pointer to the db where the student will be added.
  @param Student student to add to the db.
*/
void addNewStudent(StudentDb * db, Student student)
{
  student.id = db->lastIdAssigned + 1;
  db->lastIdAssigned++;
  addStudent(db, student);
}

/**
  Gets a student from the provided db by the provided id.
  @param db a pointer to the db where the student is in.
  @param id the id of the student.
  @return A pointer to the student or NULL if the id is not found.
*/
Student * getStudent(StudentDb * db, unsigned id)
{
  StudentNode * node;
  for(node = db->first; node != NULL; node = node->next)
  {
    if(node->student.id == id)
      return &(node->student);
  }

  return NULL;
}

void destroyDbNode(StudentNode * node)
{
  if(node->next != NULL)
    destroyDbNode(node->next);

  free(node);
}

/**
  Release all the memory related to the db.
*/
void destroyDb(StudentDb * db)
{
  if(db->first != NULL)
    destroyDbNode(db->first);
  db->first = NULL;
  db->last = NULL;
  db->count = 0;
  db->lastIdAssigned = 0;
}
