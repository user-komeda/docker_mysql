CREATE USER 'sample_user' IDENTIFIED BY 'PassWord@9219';
GRANT ALL PRIVILEGES ON *.* TO 'sample_user'@'%' WITH GRANT OPTION;
