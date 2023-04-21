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



-- HANDLE NEW USER WHEN CREATED

DROP TRIGGER if exists on_auth_user_created on auth.users;
drop function if exists handle_new_user;
create function public.handle_new_user() 
returns trigger as $$
begin
  insert into 
  public.user (
    user_uid,
    name,
    phone,
    address,
    age,
    national_id,
    gender
    )
  values (
    new.id,
    new.raw_user_meta_data->>'name',
    new.raw_user_meta_data->>'phone',
    new.raw_user_meta_data->>'address',
    CAST (new.raw_user_meta_data->>'age' AS integer),
    new.raw_user_meta_data->>'national_id' ,
    CAST(new.raw_user_meta_data->>'gender' AS boolean)    
    );
  return new;
end;
$$ language plpgsql security definer;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();





-- CREATE DEFAULT ROLE FOR NEW USER WHEN JOINED

DROP TRIGGER if exists on_insert_user_table on public.user;
drop function if exists handle_insert_user;
create function public.handle_insert_user() 
returns trigger as $$
begin
  insert into 
  public.user_role (
    user_id,
    role_id
    )
  values (
    new.user_id,
    4
    );
  return new;
end;
$$ language plpgsql security definer;
create trigger on_insert_user_table
  after insert on public.user
  for each row execute procedure public.handle_insert_user();




--DOCTOR VIEW

CREATE or REPLACE VIEW doctor_view as (
  SELECT 
  u.user_id, 
  u.name, 
  u.title,
  u.gender,
  u.age, 
  ur.role_id, 
  r.name as "role_name",
  db.branch_id,
  hd.hospital_id

  FROM public."user" u
  INNER JOIN user_role ur on u.user_id = ur.user_id and ur.role_id = 3
  INNER JOIN public."role" r on r.role_id = ur.role_id
  LEFT JOIN public."doctor_branch" db on db.doctor_id = u.user_id
  LEFT JOIN public."hospital_doctor" hd on hd.doctor_id = u.user_id
);

SELECT * FROM doctor_view LIMIT 20;

--APPOINTMENT HISTORY VIEW

DROP VIEW IF EXISTS appointment_history_view;
CREATE or REPLACE VIEW appointment_history_view as (
  SELECT 
  a.*,
  doctor.name as "doctor_name",
  patient.name as "patient_name",
  b.name as "branch_name",
  h.name as "hospital_name"
  FROM public."appointment" a
  LEFT JOIN public."user" doctor on a.doctor_id = doctor.user_id
  LEFT JOIN public."user" patient on a.patient_id = patient.user_id
  LEFT JOIN public."branch" b on b.branch_id = a.branch_id
  LEFT JOIN public."hospital" h on h.id = a.hospital_id
);

SELECT * FROM appointment_history_view LIMIT 20;





-- SEND NOTIFICATION WHEN APPOINTMENT IS CANCELLED

DROP TRIGGER if exists on_update_appointment on public."appointment";
drop function if exists handle_appointment_update;
create function public.handle_appointment_update() 
returns trigger as $$
  -- Fetch user_id from public.user table based on user_uid = auth.uid()
 DECLARE
  user_id INTEGER;
  user_name VARCHAR(255);
BEGIN
  if new.is_cancelled = true then
      -- Fetch user_id and name from public.user table based on user_uid = auth.uid()
    SELECT u.user_id, u.name 
    INTO user_id, user_name
    FROM public."user" u
    WHERE u.user_uid = auth.uid();

    -- Insert row into notifications table with title "cancel" and description "$name cancelled reservation"
    INSERT INTO notification (user_id, title, description)
    VALUES (case when user_id = new.doctor_id then new.patient_id else new.doctor_id end, 'Randevu İptali', user_name || ' randevuyu iptal etti');
  end if;
  RETURN NEW;
END;
$$ language plpgsql security definer;
create trigger on_update_appointment
  after update on public."appointment"
  for each row execute procedure public.handle_appointment_update();








-- PROFILE VIEW

  CREATE or REPLACE VIEW profile as (
  SELECT u.*, ur.role_id, r.name as "role_name"
  FROM public."user" u
  LEFT JOIN user_role ur on u.user_id = ur.user_id
  LEFT JOIN public."role" r on r.role_id = ur.role_id
);

SELECT * FROM profile LIMIT 20;