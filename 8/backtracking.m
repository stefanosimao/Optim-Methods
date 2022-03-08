function [alpha]=backtracking(f,df,alpha,rho,c,x_k,y_k,p_k)

f_xk = f(x_k, y_k);
gradf_k = df(x_k, y_k)';

while (f(x_k + alpha * p_k(1), y_k + alpha * p_k(2)) > f_xk + c * alpha * (gradf_k' * p_k))
    alpha = alpha * rho;
end
