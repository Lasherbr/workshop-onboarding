create database if not exists `demo`;
grant all privileges on demouser.* to demo@'localhost' identified by 'demopass';
grant all privileges on demouser.* to demo@'%' identified by 'demopass';
use demo;
create table if not exists demo_images ( id_image int auto_increment primary key not null, nome_imagem varchar(255), hash_imagem varchar(255), imagem text, tipo varchar(20), tempo_ms float);
