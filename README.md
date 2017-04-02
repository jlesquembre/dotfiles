# dotfiles

My personal dotfiles. For more info on how this is deployed, see
[Super User Spark](https://github.com/NorfairKing/super-user-spark) and
[the Spark language](https://github.com/NorfairKing/super-user-spark/blob/master/doc/language.md).

# Usage


```
spark check main.sus
```


```
spark deploy -r main.sus
```


# NixOS install


Check if there is an user and is on `wheel` group:

```
extraGroups = [ "wheel" ];
```


```
wget http://bit.do/jlnix -O init.sh
bash init.sh
spark deploy main.sus
nix-env -ir all
```
