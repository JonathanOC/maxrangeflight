function [a b c d] = testf(t, state)

x = state(1);
y = state(2);
v = state(3);
u = state(4);


a = t + state;
b = 1;
c = 1;
d = 1;