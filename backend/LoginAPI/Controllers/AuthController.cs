using LoginAPI.Models;
using LoginAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace LoginAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;
        private readonly ILogger<AuthController> _logger;

        public AuthController(IAuthService authService, ILogger<AuthController> logger)
        {
            _authService = authService;
            _logger = logger;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(new ApiResponse { Success = false, Message = "Invalid input" });

                var result = await _authService.LoginAsync(request);
                if (result == null)
                    return Unauthorized(new ApiResponse { Success = false, Message = "Invalid email or password" });

                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error during login");
                return StatusCode(500, new ApiResponse { Success = false, Message = "An error occurred during login" });
            }
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(new ApiResponse { Success = false, Message = "Invalid input" });

                var result = await _authService.RegisterAsync(request);
                if (!result.Success)
                    return BadRequest(result);

                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error during registration");
                return StatusCode(500, new ApiResponse { Success = false, Message = "An error occurred during registration" });
            }
        }

        [HttpGet("verify")]
        public IActionResult Verify()
        {
            var email = User.FindFirst("email")?.Value;
            if (string.IsNullOrEmpty(email))
                return Unauthorized();

            return Ok(new { email, message = "Token is valid" });
        }
    }
}
