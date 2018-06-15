#include <string>
#include "hellolib_export.h"

namespace hello {
class HELLOLIB_EXPORT hellolib {
 public:
  [[nodiscard]] int32_t saySomething(const std::string &something) const
      noexcept;
};
}  // namespace hello