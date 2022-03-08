function [p] = FindP(delta_k, x_k, g, B_k)
g_k = g(x_k(1), x_k(2));
p_b = -B_k\g_k;

if norm(p_b) <= delta_k
    p = p_b;
else
    p_u = -(transpose(g_k) * g_k) / (transpose(g_k) * B_k * g_k) * g_k;
    if norm(p_u) > delta_k
        if (transpose(g_k) * B_k * g_k) <= 0
            tau = 1;
        else
            tau = min((norm(g_k))^3/(delta_k * (transpose(g_k) * B_k * g_k)),1);
        end
    p = -tau * (delta_k/norm(g_k)) * g_k;
    else
        syms t
        tau = solve (norm(p_u + t * (p_b - p_u)) == delta_k, t);
        tau = max(tau(1), tau(2));
        tau = double(tau);
        p = p_u + tau * (p_b - p_u);
    end
end
end
        