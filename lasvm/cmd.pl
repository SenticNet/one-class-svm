for($k=1;$k<11;$k++){

system("./la_svm -g 0.005 -c 100 ../rnn/train".$k.".lib");
system("./la_test ../rnn/test".$k.".lib train".$k.".lib.model out");
system("cp pred_y.txt pred".$k."_y.txt");
system("cp result.txt result".$k.".txt");
}
