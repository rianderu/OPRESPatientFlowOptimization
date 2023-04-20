%% Patient Time Optimization

x1 = optimvar('x1', 'LowerBound', 1, 'UpperBound', 30); %resources for each patient
x2 = optimvar('x2', 'LowerBound', 0, 'UpperBound', 0); %time in
x3 = optimvar('x3', 'LowerBound', 225, 'UpperBound', inf); %time out
x4 = optimvar('x4', 'LowerBound', 0, 'UpperBound', inf); %max amount of time for patient
x5 = optimvar('x5', 'LowerBound', 0, 'UpperBound', inf); %number of patients
x6 = optimvar('x6', 'LowerBound', 0, 'UpperBound', 30); %max capacity of ER



pfo = optimproblem('Objective', sum(x4), 'ObjectiveSense','min');

pfo.Constraints.c1 = x1 <= 30; %Total number of resources assigned to all patients cannot exceed the total resources available
pfo.Constraints.c2 = x5 <= x6; %The total number of patients in the system cannot exceed the maximum capacity of the ER
pfo.Constraints.c3 = x3 <= 360; %The time that each patient leaves the system must be less than or equal to the total time allowed
pfo.Constraints.c4 = x4 == x3-x2; %The time that each patient spends in the system is the difference between the time that the patient leaves the system and the time that the patient enters the system
pfo.Constraints.c5 = x3 >= x2+x4; %The time that each patient leaves the system must be greater than or equal to the time that the patient enters the system plus the time required for service
pfo.Constraints.c6 = x1 >=1; %The resources assigned to each patient must be non-negative
pfo.Constraints.c7 = x3 >=1; %The time out of each patient must be non-negative
pfo.Constraints.c8 = x4 >=1; %The time out of each patient must be non-negative
pfo.Constraints.c9 = x5 >=1; %Number of patients must be non-negative

ps1 = prob2struct(pfo);
[sol_1, fval_1, exitflag_1, output_1] = linprog(ps1)

