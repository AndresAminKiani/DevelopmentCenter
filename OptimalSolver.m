r_low = 1 - min(row); 
r_up = 316 - max(row);
c_low = 1 - min(col); 
c_up = 316 - max(col);
rot_low = -10;
rot_up = 10;
r = 1 - min(row) : 316 - max(row);

fmin_align(Img_Fixed, Img_Mov, [5, 5, 5])
func1 = @(x) fmin_align(Img_Fixed, Img_Mov, x);
func1([5, 5, 5])
fmincon(func1, [5, 5, 5], [], [], [], [], [r_low, c_low, rot_low], [r_up, c_up, rot_up])

func2 = @(x) fminAL(X, x);
func2([15 0])
fmincon(func2, [15, 0], [], [], [], [], [-50, 50], [-50, 50])
options = optimset('Display', 'iter', 'PlotFcns', @optimplotfval);
options2 = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[y, val, exitflag, output] = fminsearch(func2, [15 0], options);
[x] = fmincon(func2, [0, 0], [], [], [], [], [-50, -50], [50, 50], [], options2);

%%
func3 = @(x) fminAL1(X, x);
func3(15)
options = optimset('Display', 'iter', 'PlotFcns', @optimplotfval);
options2 = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[y, val, exitflag, output] = fminsearch(func3, [-85], options);
[x] = fmincon(func3, [-50], [], [], [], [], [-50], [50], [], options2);
%%
func4 = @(x) fminAL2(X, x);
func4([15 0 0 0])
options = optimset('Display', 'iter', 'PlotFcns', @optimplotfval);
options2 = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[y, val, exitflag, output] = fminsearch(func4, [0 0 0 0], options);
[x] = fmincon(func3, [-50], [], [], [], [], [-50], [50], [], options2);

%%
icon = [0 0 0 0 0 0 0 0 0 0 0 0];
func4 = @(x) fminAL2(X, x);
func4(icon)
options = optimset('Display', 'iter', 'PlotFcns', @optimplotfval);
options2 = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[y, val, exitflag, output] = fminsearch(func4, icon, options);
[x] = fmincon(func3, [-50], [], [], [], [], [-50], [50], [], options2);

%%
icon = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
func5 = @(x) fminAL3(X, x);
func5(icon)
options = optimset('Display', 'iter', 'PlotFcns', @optimplotfval);
options2 = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[y, val, exitflag, output] = fminsearch(func5, icon, options);
% [x] = fmincon(func3, [-50], [], [], [], [], [-50], [50], [], options2);

%%
icon = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
func5 = @(x) fminAL3sub(X, x);
func5(icon)
options = optimset('Display', 'iter', 'PlotFcns', @optimplotfval);
options2 = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[y, val, exitflag, output] = fminsearch(func5, icon, options);
% [x] = fmincon(func3, [-50], [], [], [], [], [-50], [50], [], options2);
