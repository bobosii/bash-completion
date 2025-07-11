# Yanlis anlasilma.

Onceleri herhangi bir sekilde path vesaire vermememizi istiyordu,
Fakat tam olarak istegi o olmadigini anladik sonradan bu yuzden es2panda binarysini usr/bin icerisine tasimayacagiz.
Sadece hali hazirda olan $PATH in sonuna append edecegiz.
Bizden istedigi completionlar icin source vermememiz.
Bunu da her shell icin ayri bash komutlari yazarak her biri icin ayri olarak bulunan pathlere gomerek saglayacagiz.


## 1. zsh icin olan path.
/usr/share/zsh/functions/Completion/Unix

Ornek dosya uzantili path:
/usr/share/functions/Completion/Unix/_es2panda

## 2. Bash icin olan path
/usr/share/bash-completions/completions/

Ornek dosya uzantili path:
/usr/share/bash-completion/completions/_es2panda


## 3. Fish icin olan.
~/.config/fish/completions/es2panda.fish

## Bizim yapmamiz gereken
Butun scriptler icin ayri olacak sekilde convertlemek, sonrasinda ise kurulum asamasinda bunu kontrol ederek
Gerekli kurulumlari yapmak. Ayni zamanda bir kullanici birden fazla shell kullaniyor olabilir bunun icin
Gerekli kontrolleri yapmak.


Sonrasinda ise kurulumlar tamam olacaktir

## Es2panda binarysinin pathi
varsayilan olarak $HOME/arkcompiler/build/bin/es2panda olarak alacagiz.
Kurulum asamasinda bunu da sorgulayacagiz tabi ki.
Eger farkli bir yere kurulmussa dogru pathi eklememiz gerekecek.


