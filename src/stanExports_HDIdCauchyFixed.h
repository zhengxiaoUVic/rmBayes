// Generated by rstantools.  Do not edit by hand.

/*
    rmBayes is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    rmBayes is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with rmBayes.  If not, see <http://www.gnu.org/licenses/>.
*/
#ifndef MODELS_HPP
#define MODELS_HPP
#define STAN__SERVICES__COMMAND_HPP
#include <rstan/rstaninc.hpp>
// Code generated by Stan version 2.21.0
#include <stan/model/model_header.hpp>
namespace model_HDIdCauchyFixed_namespace {
using std::istream;
using std::string;
using std::stringstream;
using std::vector;
using stan::io::dump;
using stan::math::lgamma;
using stan::model::prob_grad;
using namespace stan::math;
static int current_statement_begin__;
stan::io::program_reader prog_reader__() {
    stan::io::program_reader reader;
    reader.add_event(0, 0, "start", "model_HDIdCauchyFixed");
    reader.add_event(48, 46, "end", "model_HDIdCauchyFixed");
    return reader;
}
#include <stan_meta_header.hpp>
class model_HDIdCauchyFixed
  : public stan::model::model_base_crtp<model_HDIdCauchyFixed> {
private:
        int N;
        int C;
        std::vector<vector_d> Y;
        double tcrit;
        matrix_d Q;
public:
    model_HDIdCauchyFixed(stan::io::var_context& context__,
        std::ostream* pstream__ = 0)
        : model_base_crtp(0) {
        ctor_body(context__, 0, pstream__);
    }
    model_HDIdCauchyFixed(stan::io::var_context& context__,
        unsigned int random_seed__,
        std::ostream* pstream__ = 0)
        : model_base_crtp(0) {
        ctor_body(context__, random_seed__, pstream__);
    }
    void ctor_body(stan::io::var_context& context__,
                   unsigned int random_seed__,
                   std::ostream* pstream__) {
        typedef double local_scalar_t__;
        boost::ecuyer1988 base_rng__ =
          stan::services::util::create_rng(random_seed__, 0);
        (void) base_rng__;  // suppress unused var warning
        current_statement_begin__ = -1;
        static const char* function__ = "model_HDIdCauchyFixed_namespace::model_HDIdCauchyFixed";
        (void) function__;  // dummy to suppress unused var warning
        size_t pos__;
        (void) pos__;  // dummy to suppress unused var warning
        std::vector<int> vals_i__;
        std::vector<double> vals_r__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning
        try {
            // initialize data block variables from context__
            current_statement_begin__ = 2;
            context__.validate_dims("data initialization", "N", "int", context__.to_vec());
            N = int(0);
            vals_i__ = context__.vals_i("N");
            pos__ = 0;
            N = vals_i__[pos__++];
            check_greater_or_equal(function__, "N", N, 1);
            current_statement_begin__ = 3;
            context__.validate_dims("data initialization", "C", "int", context__.to_vec());
            C = int(0);
            vals_i__ = context__.vals_i("C");
            pos__ = 0;
            C = vals_i__[pos__++];
            check_greater_or_equal(function__, "C", C, 2);
            current_statement_begin__ = 4;
            validate_non_negative_index("Y", "C", C);
            validate_non_negative_index("Y", "N", N);
            context__.validate_dims("data initialization", "Y", "vector_d", context__.to_vec(N,C));
            Y = std::vector<Eigen::Matrix<double, Eigen::Dynamic, 1> >(N, Eigen::Matrix<double, Eigen::Dynamic, 1>(C));
            vals_r__ = context__.vals_r("Y");
            pos__ = 0;
            size_t Y_j_1_max__ = C;
            size_t Y_k_0_max__ = N;
            for (size_t j_1__ = 0; j_1__ < Y_j_1_max__; ++j_1__) {
                for (size_t k_0__ = 0; k_0__ < Y_k_0_max__; ++k_0__) {
                    Y[k_0__](j_1__) = vals_r__[pos__++];
                }
            }
            current_statement_begin__ = 5;
            context__.validate_dims("data initialization", "tcrit", "double", context__.to_vec());
            tcrit = double(0);
            vals_r__ = context__.vals_r("tcrit");
            pos__ = 0;
            tcrit = vals_r__[pos__++];
            current_statement_begin__ = 6;
            validate_non_negative_index("Q", "C", C);
            validate_non_negative_index("Q", "(C - 1)", (C - 1));
            context__.validate_dims("data initialization", "Q", "matrix_d", context__.to_vec(C,(C - 1)));
            Q = Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic>(C, (C - 1));
            vals_r__ = context__.vals_r("Q");
            pos__ = 0;
            size_t Q_j_2_max__ = (C - 1);
            size_t Q_j_1_max__ = C;
            for (size_t j_2__ = 0; j_2__ < Q_j_2_max__; ++j_2__) {
                for (size_t j_1__ = 0; j_1__ < Q_j_1_max__; ++j_1__) {
                    Q(j_1__, j_2__) = vals_r__[pos__++];
                }
            }
            // initialize transformed data variables
            // execute transformed data statements
            // validate transformed data
            // validate, set parameter ranges
            num_params_r__ = 0U;
            param_ranges_i__.clear();
            current_statement_begin__ = 10;
            num_params_r__ += 1;
            current_statement_begin__ = 11;
            num_params_r__ += 1;
            current_statement_begin__ = 12;
            num_params_r__ += 1;
            current_statement_begin__ = 13;
            num_params_r__ += 1;
            current_statement_begin__ = 14;
            validate_non_negative_index("tf", "(C - 1)", (C - 1));
            num_params_r__ += (C - 1);
            current_statement_begin__ = 15;
            validate_non_negative_index("b", "N", N);
            num_params_r__ += N;
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
    }
    ~model_HDIdCauchyFixed() { }
    void transform_inits(const stan::io::var_context& context__,
                         std::vector<int>& params_i__,
                         std::vector<double>& params_r__,
                         std::ostream* pstream__) const {
        typedef double local_scalar_t__;
        stan::io::writer<double> writer__(params_r__, params_i__);
        size_t pos__;
        (void) pos__; // dummy call to supress warning
        std::vector<double> vals_r__;
        std::vector<int> vals_i__;
        current_statement_begin__ = 10;
        if (!(context__.contains_r("mu")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable mu missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("mu");
        pos__ = 0U;
        context__.validate_dims("parameter initialization", "mu", "double", context__.to_vec());
        double mu(0);
        mu = vals_r__[pos__++];
        try {
            writer__.scalar_unconstrain(mu);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable mu: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        current_statement_begin__ = 11;
        if (!(context__.contains_r("sigma")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable sigma missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("sigma");
        pos__ = 0U;
        context__.validate_dims("parameter initialization", "sigma", "double", context__.to_vec());
        double sigma(0);
        sigma = vals_r__[pos__++];
        try {
            writer__.scalar_lb_unconstrain(0, sigma);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable sigma: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        current_statement_begin__ = 12;
        if (!(context__.contains_r("eta")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable eta missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("eta");
        pos__ = 0U;
        context__.validate_dims("parameter initialization", "eta", "double", context__.to_vec());
        double eta(0);
        eta = vals_r__[pos__++];
        try {
            writer__.scalar_lb_unconstrain(0, eta);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable eta: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        current_statement_begin__ = 13;
        if (!(context__.contains_r("tau")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable tau missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("tau");
        pos__ = 0U;
        context__.validate_dims("parameter initialization", "tau", "double", context__.to_vec());
        double tau(0);
        tau = vals_r__[pos__++];
        try {
            writer__.scalar_lb_unconstrain(0, tau);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable tau: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        current_statement_begin__ = 14;
        if (!(context__.contains_r("tf")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable tf missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("tf");
        pos__ = 0U;
        validate_non_negative_index("tf", "(C - 1)", (C - 1));
        context__.validate_dims("parameter initialization", "tf", "vector_d", context__.to_vec((C - 1)));
        Eigen::Matrix<double, Eigen::Dynamic, 1> tf((C - 1));
        size_t tf_j_1_max__ = (C - 1);
        for (size_t j_1__ = 0; j_1__ < tf_j_1_max__; ++j_1__) {
            tf(j_1__) = vals_r__[pos__++];
        }
        try {
            writer__.vector_unconstrain(tf);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable tf: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        current_statement_begin__ = 15;
        if (!(context__.contains_r("b")))
            stan::lang::rethrow_located(std::runtime_error(std::string("Variable b missing")), current_statement_begin__, prog_reader__());
        vals_r__ = context__.vals_r("b");
        pos__ = 0U;
        validate_non_negative_index("b", "N", N);
        context__.validate_dims("parameter initialization", "b", "vector_d", context__.to_vec(N));
        Eigen::Matrix<double, Eigen::Dynamic, 1> b(N);
        size_t b_j_1_max__ = N;
        for (size_t j_1__ = 0; j_1__ < b_j_1_max__; ++j_1__) {
            b(j_1__) = vals_r__[pos__++];
        }
        try {
            writer__.vector_unconstrain(b);
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(std::runtime_error(std::string("Error transforming variable b: ") + e.what()), current_statement_begin__, prog_reader__());
        }
        params_r__ = writer__.data_r();
        params_i__ = writer__.data_i();
    }
    void transform_inits(const stan::io::var_context& context,
                         Eigen::Matrix<double, Eigen::Dynamic, 1>& params_r,
                         std::ostream* pstream__) const {
      std::vector<double> params_r_vec;
      std::vector<int> params_i_vec;
      transform_inits(context, params_i_vec, params_r_vec, pstream__);
      params_r.resize(params_r_vec.size());
      for (int i = 0; i < params_r.size(); ++i)
        params_r(i) = params_r_vec[i];
    }
    template <bool propto__, bool jacobian__, typename T__>
    T__ log_prob(std::vector<T__>& params_r__,
                 std::vector<int>& params_i__,
                 std::ostream* pstream__ = 0) const {
        typedef T__ local_scalar_t__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // dummy to suppress unused var warning
        T__ lp__(0.0);
        stan::math::accumulator<T__> lp_accum__;
        try {
            stan::io::reader<local_scalar_t__> in__(params_r__, params_i__);
            // model parameters
            current_statement_begin__ = 10;
            local_scalar_t__ mu;
            (void) mu;  // dummy to suppress unused var warning
            if (jacobian__)
                mu = in__.scalar_constrain(lp__);
            else
                mu = in__.scalar_constrain();
            current_statement_begin__ = 11;
            local_scalar_t__ sigma;
            (void) sigma;  // dummy to suppress unused var warning
            if (jacobian__)
                sigma = in__.scalar_lb_constrain(0, lp__);
            else
                sigma = in__.scalar_lb_constrain(0);
            current_statement_begin__ = 12;
            local_scalar_t__ eta;
            (void) eta;  // dummy to suppress unused var warning
            if (jacobian__)
                eta = in__.scalar_lb_constrain(0, lp__);
            else
                eta = in__.scalar_lb_constrain(0);
            current_statement_begin__ = 13;
            local_scalar_t__ tau;
            (void) tau;  // dummy to suppress unused var warning
            if (jacobian__)
                tau = in__.scalar_lb_constrain(0, lp__);
            else
                tau = in__.scalar_lb_constrain(0);
            current_statement_begin__ = 14;
            Eigen::Matrix<local_scalar_t__, Eigen::Dynamic, 1> tf;
            (void) tf;  // dummy to suppress unused var warning
            if (jacobian__)
                tf = in__.vector_constrain((C - 1), lp__);
            else
                tf = in__.vector_constrain((C - 1));
            current_statement_begin__ = 15;
            Eigen::Matrix<local_scalar_t__, Eigen::Dynamic, 1> b;
            (void) b;  // dummy to suppress unused var warning
            if (jacobian__)
                b = in__.vector_constrain(N, lp__);
            else
                b = in__.vector_constrain(N);
            // transformed parameters
            current_statement_begin__ = 19;
            validate_non_negative_index("t", "C", C);
            Eigen::Matrix<local_scalar_t__, Eigen::Dynamic, 1> t(C);
            stan::math::initialize(t, DUMMY_VAR__);
            stan::math::fill(t, DUMMY_VAR__);
            // transformed parameters block statements
            current_statement_begin__ = 20;
            stan::math::assign(t, multiply(Q, tf));
            // validate transformed parameters
            const char* function__ = "validate transformed params";
            (void) function__;  // dummy to suppress unused var warning
            current_statement_begin__ = 19;
            size_t t_j_1_max__ = C;
            for (size_t j_1__ = 0; j_1__ < t_j_1_max__; ++j_1__) {
                if (stan::math::is_uninitialized(t(j_1__))) {
                    std::stringstream msg__;
                    msg__ << "Undefined transformed parameter: t" << "(" << j_1__ << ")";
                    stan::lang::rethrow_located(std::runtime_error(std::string("Error initializing variable t: ") + msg__.str()), current_statement_begin__, prog_reader__());
                }
            }
            // model body
            current_statement_begin__ = 25;
            for (int i = 1; i <= N; ++i) {
                current_statement_begin__ = 26;
                lp_accum__.add(normal_log<propto__>(get_base1(Y, i, "Y", 1), add(add(mu, t), get_base1(b, i, "b", 1)), sigma));
            }
            current_statement_begin__ = 28;
            lp_accum__.add(normal_log<propto__>(tf, 0, eta));
            current_statement_begin__ = 29;
            lp_accum__.add(normal_log<propto__>(b, 0, tau));
            current_statement_begin__ = 33;
            lp_accum__.add(-(stan::math::log(sigma)));
            current_statement_begin__ = 34;
            lp_accum__.add(cauchy_log<propto__>(eta, 0, 1));
            current_statement_begin__ = 35;
            lp_accum__.add(cauchy_log<propto__>(tau, 0, 1));
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
        lp_accum__.add(lp__);
        return lp_accum__.sum();
    } // log_prob()
    template <bool propto, bool jacobian, typename T_>
    T_ log_prob(Eigen::Matrix<T_,Eigen::Dynamic,1>& params_r,
               std::ostream* pstream = 0) const {
      std::vector<T_> vec_params_r;
      vec_params_r.reserve(params_r.size());
      for (int i = 0; i < params_r.size(); ++i)
        vec_params_r.push_back(params_r(i));
      std::vector<int> vec_params_i;
      return log_prob<propto,jacobian,T_>(vec_params_r, vec_params_i, pstream);
    }
    void get_param_names(std::vector<std::string>& names__) const {
        names__.resize(0);
        names__.push_back("mu");
        names__.push_back("sigma");
        names__.push_back("eta");
        names__.push_back("tau");
        names__.push_back("tf");
        names__.push_back("b");
        names__.push_back("t");
        names__.push_back("se");
        names__.push_back("hdi");
    }
    void get_dims(std::vector<std::vector<size_t> >& dimss__) const {
        dimss__.resize(0);
        std::vector<size_t> dims__;
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dims__.push_back((C - 1));
        dimss__.push_back(dims__);
        dims__.resize(0);
        dims__.push_back(N);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dims__.push_back(C);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dims__.push_back(C);
        dims__.push_back(2);
        dimss__.push_back(dims__);
    }
    template <typename RNG>
    void write_array(RNG& base_rng__,
                     std::vector<double>& params_r__,
                     std::vector<int>& params_i__,
                     std::vector<double>& vars__,
                     bool include_tparams__ = true,
                     bool include_gqs__ = true,
                     std::ostream* pstream__ = 0) const {
        typedef double local_scalar_t__;
        vars__.resize(0);
        stan::io::reader<local_scalar_t__> in__(params_r__, params_i__);
        static const char* function__ = "model_HDIdCauchyFixed_namespace::write_array";
        (void) function__;  // dummy to suppress unused var warning
        // read-transform, write parameters
        double mu = in__.scalar_constrain();
        vars__.push_back(mu);
        double sigma = in__.scalar_lb_constrain(0);
        vars__.push_back(sigma);
        double eta = in__.scalar_lb_constrain(0);
        vars__.push_back(eta);
        double tau = in__.scalar_lb_constrain(0);
        vars__.push_back(tau);
        Eigen::Matrix<double, Eigen::Dynamic, 1> tf = in__.vector_constrain((C - 1));
        size_t tf_j_1_max__ = (C - 1);
        for (size_t j_1__ = 0; j_1__ < tf_j_1_max__; ++j_1__) {
            vars__.push_back(tf(j_1__));
        }
        Eigen::Matrix<double, Eigen::Dynamic, 1> b = in__.vector_constrain(N);
        size_t b_j_1_max__ = N;
        for (size_t j_1__ = 0; j_1__ < b_j_1_max__; ++j_1__) {
            vars__.push_back(b(j_1__));
        }
        double lp__ = 0.0;
        (void) lp__;  // dummy to suppress unused var warning
        stan::math::accumulator<double> lp_accum__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning
        if (!include_tparams__ && !include_gqs__) return;
        try {
            // declare and define transformed parameters
            current_statement_begin__ = 19;
            validate_non_negative_index("t", "C", C);
            Eigen::Matrix<double, Eigen::Dynamic, 1> t(C);
            stan::math::initialize(t, DUMMY_VAR__);
            stan::math::fill(t, DUMMY_VAR__);
            // do transformed parameters statements
            current_statement_begin__ = 20;
            stan::math::assign(t, multiply(Q, tf));
            if (!include_gqs__ && !include_tparams__) return;
            // validate transformed parameters
            const char* function__ = "validate transformed params";
            (void) function__;  // dummy to suppress unused var warning
            // write transformed parameters
            if (include_tparams__) {
                size_t t_j_1_max__ = C;
                for (size_t j_1__ = 0; j_1__ < t_j_1_max__; ++j_1__) {
                    vars__.push_back(t(j_1__));
                }
            }
            if (!include_gqs__) return;
            // declare and define generated quantities
            current_statement_begin__ = 40;
            double se;
            (void) se;  // dummy to suppress unused var warning
            stan::math::initialize(se, DUMMY_VAR__);
            stan::math::fill(se, DUMMY_VAR__);
            current_statement_begin__ = 41;
            validate_non_negative_index("hdi", "C", C);
            validate_non_negative_index("hdi", "2", 2);
            Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic> hdi(C, 2);
            stan::math::initialize(hdi, DUMMY_VAR__);
            stan::math::fill(hdi, DUMMY_VAR__);
            // generated quantities statements
            current_statement_begin__ = 43;
            stan::math::assign(se, (sigma / stan::math::sqrt(N)));
            current_statement_begin__ = 44;
            stan::model::assign(hdi, 
                        stan::model::cons_list(stan::model::index_omni(), stan::model::cons_list(stan::model::index_uni(1), stan::model::nil_index_list())), 
                        subtract(add(mu, t), (tcrit * se)), 
                        "assigning variable hdi");
            current_statement_begin__ = 45;
            stan::model::assign(hdi, 
                        stan::model::cons_list(stan::model::index_omni(), stan::model::cons_list(stan::model::index_uni(2), stan::model::nil_index_list())), 
                        add(add(mu, t), (tcrit * se)), 
                        "assigning variable hdi");
            // validate, write generated quantities
            current_statement_begin__ = 40;
            check_greater_or_equal(function__, "se", se, 0);
            vars__.push_back(se);
            current_statement_begin__ = 41;
            size_t hdi_j_2_max__ = 2;
            size_t hdi_j_1_max__ = C;
            for (size_t j_2__ = 0; j_2__ < hdi_j_2_max__; ++j_2__) {
                for (size_t j_1__ = 0; j_1__ < hdi_j_1_max__; ++j_1__) {
                    vars__.push_back(hdi(j_1__, j_2__));
                }
            }
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
    }
    template <typename RNG>
    void write_array(RNG& base_rng,
                     Eigen::Matrix<double,Eigen::Dynamic,1>& params_r,
                     Eigen::Matrix<double,Eigen::Dynamic,1>& vars,
                     bool include_tparams = true,
                     bool include_gqs = true,
                     std::ostream* pstream = 0) const {
      std::vector<double> params_r_vec(params_r.size());
      for (int i = 0; i < params_r.size(); ++i)
        params_r_vec[i] = params_r(i);
      std::vector<double> vars_vec;
      std::vector<int> params_i_vec;
      write_array(base_rng, params_r_vec, params_i_vec, vars_vec, include_tparams, include_gqs, pstream);
      vars.resize(vars_vec.size());
      for (int i = 0; i < vars.size(); ++i)
        vars(i) = vars_vec[i];
    }
    std::string model_name() const {
        return "model_HDIdCauchyFixed";
    }
    void constrained_param_names(std::vector<std::string>& param_names__,
                                 bool include_tparams__ = true,
                                 bool include_gqs__ = true) const {
        std::stringstream param_name_stream__;
        param_name_stream__.str(std::string());
        param_name_stream__ << "mu";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "sigma";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "eta";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "tau";
        param_names__.push_back(param_name_stream__.str());
        size_t tf_j_1_max__ = (C - 1);
        for (size_t j_1__ = 0; j_1__ < tf_j_1_max__; ++j_1__) {
            param_name_stream__.str(std::string());
            param_name_stream__ << "tf" << '.' << j_1__ + 1;
            param_names__.push_back(param_name_stream__.str());
        }
        size_t b_j_1_max__ = N;
        for (size_t j_1__ = 0; j_1__ < b_j_1_max__; ++j_1__) {
            param_name_stream__.str(std::string());
            param_name_stream__ << "b" << '.' << j_1__ + 1;
            param_names__.push_back(param_name_stream__.str());
        }
        if (!include_gqs__ && !include_tparams__) return;
        if (include_tparams__) {
            size_t t_j_1_max__ = C;
            for (size_t j_1__ = 0; j_1__ < t_j_1_max__; ++j_1__) {
                param_name_stream__.str(std::string());
                param_name_stream__ << "t" << '.' << j_1__ + 1;
                param_names__.push_back(param_name_stream__.str());
            }
        }
        if (!include_gqs__) return;
        param_name_stream__.str(std::string());
        param_name_stream__ << "se";
        param_names__.push_back(param_name_stream__.str());
        size_t hdi_j_2_max__ = 2;
        size_t hdi_j_1_max__ = C;
        for (size_t j_2__ = 0; j_2__ < hdi_j_2_max__; ++j_2__) {
            for (size_t j_1__ = 0; j_1__ < hdi_j_1_max__; ++j_1__) {
                param_name_stream__.str(std::string());
                param_name_stream__ << "hdi" << '.' << j_1__ + 1 << '.' << j_2__ + 1;
                param_names__.push_back(param_name_stream__.str());
            }
        }
    }
    void unconstrained_param_names(std::vector<std::string>& param_names__,
                                   bool include_tparams__ = true,
                                   bool include_gqs__ = true) const {
        std::stringstream param_name_stream__;
        param_name_stream__.str(std::string());
        param_name_stream__ << "mu";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "sigma";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "eta";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "tau";
        param_names__.push_back(param_name_stream__.str());
        size_t tf_j_1_max__ = (C - 1);
        for (size_t j_1__ = 0; j_1__ < tf_j_1_max__; ++j_1__) {
            param_name_stream__.str(std::string());
            param_name_stream__ << "tf" << '.' << j_1__ + 1;
            param_names__.push_back(param_name_stream__.str());
        }
        size_t b_j_1_max__ = N;
        for (size_t j_1__ = 0; j_1__ < b_j_1_max__; ++j_1__) {
            param_name_stream__.str(std::string());
            param_name_stream__ << "b" << '.' << j_1__ + 1;
            param_names__.push_back(param_name_stream__.str());
        }
        if (!include_gqs__ && !include_tparams__) return;
        if (include_tparams__) {
            size_t t_j_1_max__ = C;
            for (size_t j_1__ = 0; j_1__ < t_j_1_max__; ++j_1__) {
                param_name_stream__.str(std::string());
                param_name_stream__ << "t" << '.' << j_1__ + 1;
                param_names__.push_back(param_name_stream__.str());
            }
        }
        if (!include_gqs__) return;
        param_name_stream__.str(std::string());
        param_name_stream__ << "se";
        param_names__.push_back(param_name_stream__.str());
        size_t hdi_j_2_max__ = 2;
        size_t hdi_j_1_max__ = C;
        for (size_t j_2__ = 0; j_2__ < hdi_j_2_max__; ++j_2__) {
            for (size_t j_1__ = 0; j_1__ < hdi_j_1_max__; ++j_1__) {
                param_name_stream__.str(std::string());
                param_name_stream__ << "hdi" << '.' << j_1__ + 1 << '.' << j_2__ + 1;
                param_names__.push_back(param_name_stream__.str());
            }
        }
    }
}; // model
}  // namespace
typedef model_HDIdCauchyFixed_namespace::model_HDIdCauchyFixed stan_model;
#ifndef USING_R
stan::model::model_base& new_model(
        stan::io::var_context& data_context,
        unsigned int seed,
        std::ostream* msg_stream) {
  stan_model* m = new stan_model(data_context, seed, msg_stream);
  return *m;
}
#endif
#endif
