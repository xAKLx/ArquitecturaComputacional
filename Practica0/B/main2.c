#define DB_BINARY 1
#include <stdio.h>
#include <stdlib.h>
#include <student.h>
#include <main.h>

#ifndef DB_BINARY
#define BINARY 0
#define FILE_OPEN "r"
#define FILE_WRITE "w"
#endif

#ifdef DB_BINARY
#define BINARY 1
#define FILE_OPEN "rb"
#define FILE_WRITE "wb"
#endif

int main(int argc, char** argv)
{

  FILE *file;
  char fname[] = "studentDb";
  StudentDb db;
  int action;

  if ((file = fopen(fname, FILE_OPEN)))
  {
    db = loadStudentDb(file);
    fclose(file);
  }
  else {
    db = initDb(0,NULL,0);
  }

  if(argc > 1)
  {
    sscanf(argv[1], "%d", &action);
    executeMenuAction(&db, action);
  }
  else
  {
    while(displayMenuInterface(&db) != 5);
  }

  file = fopen(fname, FILE_WRITE);
  writeStudentDbToFile(file, db);
  destroyDb(&db);
  fclose(file);
  return 0;
}

int displayMenuInterface(StudentDb * db)
{
  int selected;

  printf("\n1. Agregar estudiante");
  printf("\n2. Imprimir estudiantes");
  printf("\n3. Buscar por id");
  printf("\n4. Borrar base de datos");
  printf("\n5. Salir");
  printf("\nIntroduzca selección: ");
  scanf("%d", &selected);

  executeMenuAction(db, selected);

  return selected;

}

void executeMenuAction(StudentDb *db, int action)
{
  switch(action)
  {
    case 1:
    displayAddStudentInterface(db);
    break;

    case 2:
    printStudents(db);
    puts("");
    break;

    case 3:
    displaySearchByIdInterface(db);
    break;

    case 4:
    printf("- base de datos borrada -");
    destroyDb(db);
    break;

  }
}

void displayAddStudentInterface(StudentDb * db)
{
  char firstName[50];
  char lastName[50];
  unsigned age;
  float gpa;

  Student student;


  printf("1. Primer Nombre:");
  scanf("%s", student.firstName);
  printf("\n2. Primer Apellido:");
  scanf("%s", student.lastName);
  printf("\n3. Edad:");
  scanf("%u", &(student.age));
  printf("\n4. GPA:");
  scanf("%f", &(student.gpa));

  addNewStudent(db, student);

}

void printStudents(StudentDb * db)
{
  StudentNode * node;
  for(node = db->first; node != NULL; node = node->next)
  {
    printStudent(node->student);
  }
}

void displaySearchByIdInterface(StudentDb * db)
{
  unsigned id;
  Student * student;

  printf("Introduzca el id: ");
  scanf("%u", &id);
  student = getStudent(db, id);

  if(student != NULL)
  {
    printStudent(*student);
  }

}

void printStudent(Student student)
{
  printf("\n%d – %s %s %u %.2f", student.id, student.firstName, student.lastName, student.age, student.gpa);
}

void writeStudentDbToFile(FILE * file, StudentDb db)
{
  StudentNode * node;

  if(0 == BINARY) {
    fprintf(file, "%d\n", db.lastIdAssigned);
    fprintf(file, "%d\n", db.count);

    for(node = db.first; node != NULL; node = node->next)
    {
      fprintf(file, "%u\n", node->student.id);
      fprintf(file, "%s\n", node->student.firstName);
      fprintf(file, "%s\n", node->student.lastName);
      fprintf(file, "%u\n", node->student.age);
      fprintf(file, "%.2f\n", node->student.gpa);
    }
  }
  else
  {
    fwrite(&db, sizeof(StudentDb), 1, file);
    for(node = db.first; node != NULL; node = node->next)
    {
      fwrite(&node->student, sizeof(Student), 1, file);
    }
  }

}

StudentDb loadStudentDb(FILE * file)
{
  if(0 == BINARY)
  {
    int lastIdAssigned;
    int count;
    int i;

    fscanf(file, "%d\n", &lastIdAssigned);
    fscanf(file, "%d\n", &count);

    Student * students = calloc(count, sizeof(Student));
    for(i = 0; i < count; i++)
    {
      fscanf(file, "%u\n", &students[i].id);
      fscanf(file, "%s\n", students[i].firstName);
      fscanf(file, "%s\n", students[i].lastName);
      fscanf(file, "%u\n", &students[i].age);
      fscanf(file, "%f\n", &students[i].gpa);
    }

    return initDb(count, students, lastIdAssigned);
  }
  else
  {
    StudentDb db;

    fread(&db,sizeof(StudentDb),1,file);
    Student * students = calloc(db.count, sizeof(Student));
    fread(students, sizeof(Student), db.count, file);

    return initDb(db.count, students, db.lastIdAssigned);
  }

}
