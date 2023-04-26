%% Patient Time Optimization

x1 = optimvar('Resources', 'type', 'integer','LowerBound', 1, 'UpperBound', 30); %resources for each patient
x2 = optimvar('TI', 'type', 'integer','LowerBound', 0, 'UpperBound', 0); %time in
x3 = optimvar('TO', 'type', 'integer','LowerBound', 225, 'UpperBound', inf); %time out
x4 = optimvar('NoOfPatients', 'type', 'integer','LowerBound', 0, 'UpperBound', inf); %number of patients
x5 = optimvar('MaxCap', 'type', 'integer','LowerBound', 30, 'UpperBound', 30); %max capacity of ER



pfo = optimproblem('Objective', sum(x3-x2), 'ObjectiveSense','min');

pfo.Constraints.c1 = x1 <= 30; %Total number of resources assigned to all patients cannot exceed the total resources available
pfo.Constraints.c2 = x4 <= x5; %The total number of patients in the system cannot exceed the maximum capacity of the ER
pfo.Constraints.c3 = x3-x2 <= 360; %The time that each patient leaves the system must be less than or equal to the total time allowed
pfo.Constraints.c4 = x1 >=1; %The resources assigned to each patient must be non-negative
pfo.Constraints.c5 = x3 >=1; %The time out of each patient must be non-negative
pfo.Constraints.c6 = x4 >=1; %Number of patients must be non-negative
pfo.Constraints.c7 = x3-x2 >=1; %The total time of each patient must be non-negative

[sol, fval] = solve(pfo)

