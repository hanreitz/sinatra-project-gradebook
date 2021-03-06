# Sample Teachers
msr = Teacher.create(first_name: "Ms", last_name: "RR", email: "msrr@cms.k12.nc.us", password: "password")
mra = Teacher.create(first_name: "Mr", last_name: "A", email: "mra@cms.k12.nc.us", password: "password")
mrb = Teacher.create(first_name: "Mr", last_name: "B", email: "mrb@cms.k12.nc.us", password: "password")

# Sample Courses
math1 = Course.create(name: "Math 1", teacher_id: mra.id)
math2 = Course.create(name: "Math 2", teacher_id: mra.id)
chem = Course.create(name: "Chemistry", teacher_id: msr.id)
eng2 = Course.create(name: "English 2", teacher_id: mrb.id)

# Sample Students
adele = Student.create(name: "Adele", grade_level: 9, contact_name: "Sandy", contact_phone: "7045551234")
lydia = Student.create(name: "Lydia", grade_level: 10, contact_name: "Sandy", contact_phone: "7045551234")
rachel = Student.create(name: "Rachel", grade_level: 10, contact_name: "Irene", contact_phone: "7045555678")
binta = Student.create(name: "Binta", grade_level: 10, contact_name: "Keisha", contact_phone: "7045559101")

# Sample Assignments
math1_intro = Assignment.create(name: "Intro to Math 1", course_id: math1.id)
math1_hw1 = Assignment.create(name: "Math 1 HW 1", course_id: math1.id)
math1_hw2 = Assignment.create(name: "Math 1 HW 2", course_id: math1.id)
math2_intro = Assignment.create(name: "Intro to Math 2", course_id: math2.id)
math2_hw1 = Assignment.create(name: "Math 2 HW 1", course_id: math2.id)
math2_hw2 = Assignment.create(name: "Math 2 HW 2", course_id: math2.id)
chem_intro = Assignment.create(name: "Intro to Chemistry", course_id: chem.id)
chem_lab1 = Assignment.create(name: "Chemistry Lab 1", course_id: chem.id)
chem_hw1 = Assignment.create(name: "Chemistry HW 1", course_id: chem.id)
eng2_intro = Assignment.create(name: "Intro to English 2", course_id: eng2.id)
eng2_essay1 = Assignment.create(name: "English 2 Essay 1", course_id: eng2.id)
eng2_quiz1 = Assignment.create(name: "English 2 Quiz 1", course_id: eng2.id)

math1.students << adele
math2.students << lydia
math2.students << rachel
math2.students << binta
chem.students << lydia
chem.students << rachel
eng2.students << adele
eng2.students << binta