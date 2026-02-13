using LoginAPI.Models;

namespace LoginAPI.Services
{
    public interface IAuthService
    {
        Task<LoginResponse?> LoginAsync(LoginRequest request);
        Task<ApiResponse> RegisterAsync(RegisterRequest request);
        string GenerateJwtToken(User user);
    }
}
