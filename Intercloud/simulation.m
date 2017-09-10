%clouds
N=4;

%pricing matrix
p_d=[0.1;0.2;0.3;0.4];
p_t=[2;4;6;8];
p_o=[0.04;0.02;0.01;0.04];
p_i=[0.02;0.02;0.01;0.03];

p=[p_d p_t p_o p_i];

%program: d=data storage t=task
d=[300;200;100;30;40];
t=[20;10000;20];
p_s_t = [0 1 0 0 0;
        1 0 1 0 0;
        0 0 0 1 1;];

%solution
s_d=[0 1 0 0
     1 0 0 0
     0 0 0 1
     0 0 1 0
     1 0 0 0
    ];
s_t=[1 0 0 0
     1 0 0 0
     0 1 0 0
    ];

%result
r_d=s_d*p_d.*d;
r_t=s_t*p_t.*t;

display(r_d);
display(r_t);

relation=p_s_t*s_d;
display(relation);