create table branch (
  branch_id bigint not null primary key,
  name character not null,
  description character,
  created_at timestamp default now()
);

create table user (
  user_id bigint not null primary key,
  name character not null,
  phone character not null,
  gender boolean,
  national_id text,
  created_at timestamp default now() not null,
  title character,
  user_uid uuid default uuid_generate_v4(),
  address text,
  age smallint
);

create table doctor_branch (
  doctor_id bigint references user (user_id) primary key,
  branch_id bigint references branch (branch_id) primary key
);

create table notification (
  id bigint not null primary key,
  title character not null,
  description character,
  created_at timestamp default now() not null,
  user_id bigint references user (user_id)
);

create table role (
  role_id bigint not null primary key,
  name character not null
);

create table user_role (
  user_id bigint references user (user_id) primary key,
  role_id bigint references role (role_id) primary key
);

create table city (
  city_id bigint not null primary key,
  name character not null,
  description character,
  created_at timestamp default now()
);

create table hospital (
  id bigint not null primary key,
  name character not null,
  description character,
  created_at timestamp default now(),
  city_id bigint references city (city_id)
);

create table hospital_doctor (
  hospital_id bigint references hospital (id) primary key,
  doctor_id bigint references user (user_id) primary key
);

create table appointment (
  appointment_id bigint not null primary key,
  patient_id bigint references user (user_id),
  doctor_id bigint references user (user_id),
  date date default now() not null,
  time time not null,
  duration_in_min smallint not null,
  created_at timestamp default now() not null,
  branch_id bigint references branch (branch_id),
  hospital_id bigint references hospital (id),
  is_cancelled boolean not null
);

